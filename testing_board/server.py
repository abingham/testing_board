from aiohttp import web
import aiohttp_cors
from collections import defaultdict

games = defaultdict(lambda: defaultdict(list))


async def handle_games(request):
    return web.json_response(list(games))


async def handle_add_results(request):
    print(request.match_info)
    game_id = request.match_info['game']
    user_id = request.match_info['user']
    data = await request.json()
    results = data['results']
    print(game_id, user_id, results)
    games[game_id][user_id] = results
    return web.Response()


async def handle_get_results(request):
    print(request.match_info)
    game_id = request.match_info['game']
    return web.json_response(dict(games[game_id]))


def main():
    app = web.Application()
    cors = aiohttp_cors.setup(app)
    app.router.add_get('/', handle_games)
    app.router.add_post('/results/{game}/{user}', handle_add_results)

    resource = cors.add(app.router.add_resource("/results/{game}"))
    cors.add(
        resource.add_route('GET', handle_get_results), {
            "*":
            aiohttp_cors.ResourceOptions(allow_credentials=False),
        })

    web.run_app(app, host='127.0.0.1', port=8080)


if __name__ == '__main__':
    main()
