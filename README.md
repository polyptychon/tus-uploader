# Description


# Requirements

- [AngularJS](http://angularjs.org/)
- [JQuery](http://jquery.com/)
- [Bootstrap](https://github.com/twbs/bootstrap/)

## Install

You can install this package either with `npm` or with `bower`.

### npm

```shell
npm install --save polyptychon/tus-uploader
```
Add a stylesheet to your `index.html` head:
```html
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/node_modules/tus-uploader/lib/css/tus-uploader.css">
```

Add a `<script>` to your `index.html`:

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.0/angular.min.js"></script>

<script src="/node_modules/tus-uploader/lib/js/tus-uploader.min.js"></script>
```

Then add `tus-uploader` as a dependency for your app:

```javascript
angular.module('myApp', ['tus-uploader']);
```

Note that this package is in CommonJS format, so you can `require('tus-uploader')`

### bower

```shell
bower install polyptychon/tus-uploader
```

Add a stylesheet to your `index.html` head:
```html
<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css">
<link rel="stylesheet" href="/bower_components/tus-uploader/lib/css/tus-uploader.css">
```

Add a `<script>` to your `index.html`:

```html
<script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>
<script src="//ajax.googleapis.com/ajax/libs/angularjs/1.3.0/angular.min.js"></script>

<script src="/bower_components/tus-uploader/lib/js/tus-uploader.min.js"></script>
```

Then add `tus-uploader` as a dependency for your app:

```javascript
angular.module('myApp', ['tus-uploader']);
```

## Documentation


