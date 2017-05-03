from aiohttp import web
import aiohttp_cors
import asyncio
from collections import defaultdict

games = defaultdict(lambda: defaultdict(list))
q = asyncio.Queue()


async def handle_games(request):
    return web.json_response(list(games))


async def handle_add_results(request):
    game_id = request.match_info['game_id']
    data = await request.json()
    results = data['results']
    user = results['user']
    games[game_id][user] = {
        'total': results['total'],
        'failures': results['failures'],
    }

    await q.put(b'new data')

    return web.Response()


async def handle_get_results(request):
    game_id = request.match_info['game_id']
    return web.json_response(dict(games[game_id]))


async def handle_notifications(request):
    ws = web.WebSocketResponse()
    await ws.prepare(request)

    while True:
        msg = await q.get()

        # or done, pending = await asyncio.wait([q.get(), ws.receive()], return_when=asyncio.FIRST_COMPLETED)
        if msg is None:
            break
        else:
            ws.send_bytes(msg)

    await ws.close()
    return ws


def main():
    app = web.Application()
    cors = aiohttp_cors.setup(app)
    app.router.add_get('/', handle_games)
    app.router.add_post('/results/{game_id}', handle_add_results)
    app.router.add_get('/notifications', handle_notifications)

    resource = cors.add(app.router.add_resource("/results/{game_id}/"))
    cors.add(
        resource.add_route('GET', handle_get_results), {
            "*":
            aiohttp_cors.ResourceOptions(allow_credentials=False),
        })

    web.run_app(app, host='127.0.0.1', port=8080)


if __name__ == '__main__':
    main()
