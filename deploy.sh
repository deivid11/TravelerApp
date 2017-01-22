echo Fast Deploy
git add .
git commit -m "Fast Deploy"
git push
ssh quetzal << EOF
    cd symfony/quetzal71/
    git pull
    composer install
    rm var/cache/* -rf
    php bin/console doctrine:schema:update --force
    php bin/console assets:install --symlink
    php bin/console assetic:dump --env=prod --no-debug
    php bin/console cache:warmup --env=prod
    exit
EOF
