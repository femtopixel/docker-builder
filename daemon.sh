#!/usr/bin/env sh

php -S "0.0.0.0:${PORT:-80}" listener.php
