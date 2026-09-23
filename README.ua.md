# Релізи Injective Chain

Цей репозиторій містить релізи бінарних артефактів Injective Chain.

Він також містить зручні інструкції та скрипти для початку роботи та керування нодами Injective Chain.

### Включені посібники

* [Посібник з налаштування сервісу Injective Exchange](https://www.notion.so/Injective-Exchange-Service-Setup-Guide-7e59980634d54991862300670583d46a) (Включає в себе запуск ноди)
* [Створіть нову ноду та приєднайтеся до мережі](guides/new-node.md)
* [Синхронізуйте ноду зі снепшотом](guides/sync-node.md) (найшвидший спосіб синхронізації блоків).
* [Оновіть ноду до останньої версії](guides/upgrade-node.md)

<!-- * [Sync node from scratch via public sentries](guides/sync-node.md) (better decentralization factor). -->


## Вимоги

Нижче наведені вимоги для роботи ноди в нативному режимі.
### Апаратне забезпечення

Наступна таблиця показує мінімальні рекомендовані вимоги до апаратного забезпечення для роботи ноди в майннеті.

| Validator Node   | Sentry Node    |
| -----------------| ---------------|
| CPU: 8 Ядер      | CPU: 8 Ядер    |
| Memory: 64Gb     | Memory: 64Gb+  |
| Storage: 2Tb     | Storage: 2Tb   |
| Network: 5Gbps+  | Network: 5Gbps+|

### Програмне забезпечення

* [Встановлений Go][go-install-link]
* [Встановлений Git][git-link]
* [AWS CLI][aws-cli-install-link] (тільки для синхронізації з снепшотом, обліковий запис AWS не потрібен)

## Sentry Seed Ноди

Для **тестової мережі**, знайдіть список seed нод в файлі seed.txt у відповідній папці релізу [тут][injective-netconf-test]

*Наприклад, для тестового релізу [0.4.19](https://github.com/InjectiveLabs/injective-chain-releases/releases/tag/v0.4.19-1656563866)
ви знайдете список seed нод `70001/seeds.txt`*

Для **головної мережі**, знайдіть список seed нод, що відповідають вашому релізу [тут][injective-netconf-main]

## Корисні посилання

* [Офіційна документація][injective-docs]
* [Injective REST API Spec (Майннет)][injective-rest-api-mainnet-link]
* [Injective REST API Spec (Тестнет)][injective-rest-api-testnet-link]

# Приєднуйтесь

Injective Protocol - це проект, який розвивається спільнотою; ми вітаємо будь-які внески.

* Обговорюйте з [спільнотою в Discord][discord-community-link]
* Приєднуйтесь до Injective в [Telegram][telegram-community-link]
* [Репозиторії Github][injective-github-repo]
* Слідкуйте за нами в [Twitter][injective-twitter-link]

[sync-node-link]:
[create-node-link]:
[upgrade-node-link]: https://docs.injective.network/docs/staking/mainnet/validate-on-mainnet/upgrading-your-node
[go-install-link]: https://golang.org/doc/install
[git-link]:https://github.com/git-guides/install-git
[aws-cli-install-link]: https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html
[discord-community-link]: https://discord.com/invite/injective
[telegram-community-link]: https://t.me/joininjective
[injective-rest-api-testnet-link]: https://k8s.testnet.lcd.injective.network/swagger/#/
[injective-rest-api-mainnet-link]: https://lcd.injective.network/swagger/#/
[injective-github-repo]: https://github.com/InjectiveLabs
[injective-docs]: https://docs.injective.network/
[injective-twitter-link]: https://twitter.com/InjectiveLabs
[injective-netconf-test]: https://github.com/InjectiveLabs/testnet-config/tree/master/corfu
[injective-netconf-main]:https://github.com/InjectiveLabs/mainnet-config

