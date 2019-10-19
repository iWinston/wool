module.exports = {
    apps : [{
        name: 'api-plus',
        script: 'dist/src/main.js',
        // Options reference: https://pm2.io/doc/en/runtime/reference/ecosystem-file/
        args: '',
        instances: 2,
        autorestart: true,
        watch: false,
        max_memory_restart: '1G',
        env: {
            NODE_ENV: 'test'
        },
        env_production: {
            NODE_ENV: 'production'
        },
        append_env_to_name: true
    }],

    deploy : {
        production : {
            user : 'root',
            host: '119.23.58.59',
            ref: 'origin/master',
            repo: 'git@github.com:iWinston/wool.git',
            path : '/var/www/wool',
            'pre-deploy': 'cd api',
            'post-deploy': 'yarn install && yarn build && pm2 reload ./ops/ops.config.js --env production'
        },
        dev : {
            user: 'root',
            host: '39.108.151.3',
            ref : 'origin/dev',
            repo: 'git@github.com:iWinston/wool.git',
            path: '/var/www/wool',
            'post-deploy': 'yarn install && yarn build && pm2 reload ./ops/ops.config.js'
        }
    }
};
