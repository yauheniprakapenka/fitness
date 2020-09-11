## Описание API

При описании используется openapi3

Описание разбивается на отдельные файлы для лучшей модульности. Файл в папке bundle является скомбинированным(однофайловым) описанием api последней версии. Этот файл генерируется автоматически, поэтому при изменении api нужно менять исходные файлы.


##  Сборка API

Описание API разбито на несколько файлов. Чтобы использовать описание в утилитах, которые требуют описание одним файлом нужно скомпоновать эти файлы. Чтобы скомпоновать описание в один файл можно использовать swagger-cli. Требует наличия node.js(npm)

Установка swagger-cli

```bash
# если при установке npm пакета глобально(-g) выдает ошибку permission denied нужно выполнить команду ниже
# -R Change the user ID and/or the group ID for the file hierarchies rooted in the files instead of just the files themselves.
# команда изменяет владельца папки на текущего юзера
sudo chown -R $USER /usr/local/lib/node_modules

npm install -g swagger-cli
```

Чтобы скомбинировать файлы нужно выполнить

```bash
swagger-cli bundle openapi3.yaml --outfile Bundled/openapi3combined.yaml --type yaml
```
