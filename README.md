# Generate NPM Authentication Token

Input credentials, output auth token.

This is a fork fork of kthse/generate-npm-authtoken. It uses `Alpine Linux` instead of a full blown Linux dist. Reducing image size to 100Mb from about 1Gb.

## Why

For some reason, the `npm login` command is interactive, and this causes problems when you need to call the command from non-interactive shells such as in a Dockerfile. By using the `kthse/generate-npm-authtoken` you can generate an auth token. Output this to `~/.npmrc` and you are now authenticated with npm and can `npm install` private npm modules.

## Usage

    docker run \
        -e NPM_USER=$NPM_USER \
        -e NPM_PASS=$NPM_PASS \
        -e NPM_EMAIL=$NPM_EMAIL \
        kthse/generate-npm-authtoken

If you want to save output to `~/.npmrc` where it doesn't exist, you can simply redirect the output.

    docker run \
        -e NPM_USER=$NPM_USER \
        -e NPM_PASS=$NPM_PASS \
        -e NPM_EMAIL=$NPM_EMAIL \
        kthse/generate-npm-authtoken \
        > ~/.npmrc

Bear in mind that this will overwrite an existing `.npmrc`, so if you don't want to do that, append it instead with `>>`. Note: when there are multiple auth tokens in `.npmrc`, npm uses the last occurrence.

    docker run \
        -e NPM_USER=$NPM_USER \
        -e NPM_PASS=$NPM_PASS \
        -e NPM_EMAIL=$NPM_EMAIL \
        kthse/generate-npm-authtoken \
        >> ~/.npmrc

## Using a different registry

If you need to use a different registry, pass the environment variable `NPM_REGISTRY` through, but make sure it has the protocol specified, i.e. `NPM_REGISTRY=https://skimdb.npmjs.com/registry`, NOT `NPM_REGISTRY=skimdb.npmjs.com/registry`.

    docker run \
        -e NPM_USER=$NPM_USER \
        -e NPM_PASS=$NPM_PASS \
        -e NPM_EMAIL=$NPM_EMAIL \
        -e NPM_REGISTRY=$NPM_REGISTRY \
        kthse/generate-npm-authtoken \
        >> ~/.npmrc

## Using a different registry with a scope

You can extend your registry login by adding a scope.

    docker run \
        -e NPM_USER=$NPM_USER \
        -e NPM_PASS=$NPM_PASS \
        -e NPM_EMAIL=$NPM_EMAIL \
        -e NPM_REGISTRY=$NPM_REGISTRY \
        -e NPM_SCOPE=$YOUR_NPM_SCOPE
         kthse/generate-npm-authtoken \
         >> ~/.npmrc

## Using the 2FA option

If your account has 2FA enabled you can pass the code.

    docker run \
        -e NPM_USER=$NPM_USER \
        -e NPM_PASS=$NPM_PASS \
        -e NPM_EMAIL=$NPM_EMAIL \
        -e NPM_REGISTRY=$NPM_REGISTRY \
        -e NPM_SCOPE=$YOUR_NPM_SCOPE \
        -e TWO_F_A_CODE=$YOUR_TWO_F_A_CODE \
         kthse/generate-npm-authtoken \
         >> ~/.npmrc

Just have in mind you should pass a **VERY FRESH** token to give the script enough time to authenticate the account while the code is valid.
