from aiohttp import web
from collections import defaultdict

games = defaultdict(lambda: defaultdict(list))


async def handle_games(request):
    return web.json_response(list(games))


async def handle_add_results(request):
    game_id = request.match_info.get('game_id')
    user_id = request.match_info.get('user_id')
    data = await request.json()
    results = data['results']
    games[game_id][user_id] = results
    return web.Response()


async def handle_get_results(request):
    game_id = request.match_info.get('game_id')
    return web.json_response(dict(games[game_id]))


def main():
    app = web.Application()
    app.router.add_get('/', handle_games)
    app.router.add_post('/results/{game_id}/{user_id}', handle_add_results)
    app.router.add_get('/results/{game_id}', handle_get_results)
    web.run_app(app, host='127.0.0.1', port=8080)


if __name__ == '__main__':
    main()
