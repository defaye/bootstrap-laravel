### Bootstrap Laravel

This script is intended for version 5.
It's a simple script that can help bootstrap your Laravel project.

To use, simply run (inside your project root directory):
```
wget -qO- https://raw.githubusercontent.com/defaye/bootstrap-laravel/master/bootstrap.sh | sh
```

Alternatively, clone [this project][1] into your project and execute the script:

```
git clone https://github.com/defaye/bootstrap-laravel.git
./bootstrap-laravel/bootstrap.sh
```

If you can't execute the script, make it executable with:

```
sudo chmod +x ./bootstrap-laravel/bootstrap.sh
```

This bootstrapper does not run `npm install` or the asset compilers:

- Laravel ~5.0 run: `gulp --production`
- ^5.3 run: `npm run prod`


#### Contributing

Please feel free to enhance this script and send me a pull request.


#### License


This project is open-sourced software licensed under the [MIT license](http://opensource.org/licenses/MIT).

[1]:https://github.com/defaye/bootstrap-laravel.git
