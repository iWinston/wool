import * as moduleAlias from 'module-alias';
import * as path from 'path';

moduleAlias.addAlias('@config', path.resolve(__dirname, '../config'));
moduleAlias.addAlias('@plugin', path.resolve(__dirname, '../plugin'));
moduleAlias.addAlias('@src', __dirname);
moduleAlias.addAlias('@common', path.resolve(__dirname, '../common'));
moduleAlias();
