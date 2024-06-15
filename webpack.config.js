const path = require('path');

module.exports = {
  entry: {
    index: '../src/main/resources/ts/index.ts',
    boot: '../src/main/resources/ts/boot.ts',
  },
  module: {
    rules: [
      {
        test: /.ts$/,
        use: 'ts-loader',
        exclude: /node_modules/,
      },
      {
        test: /\.css$/i,
        use: ['style-loader', 'css-loader'],
      },
    ],
  },
  resolve: {
    extensions: ['.ts', '.js'],
  },
  output: {
    filename: '[name].js',
    path: path.resolve(__dirname, './src/main/webapp/js'),
  },
  mode: 'development',
  devtool: 'inline-source-map',
};