nixos + homeManager config for particular host

each host creates a nixos & homeManager module named after its respective hostname

for-each host:
    create -> flake.modules.<nixos or homeManager>.<host> = {...};
    create -> flake.nixosConfiguration.<host> = {...};
    for-some users:
        create -> flake.homeConfiguration."<user>@<host>" = {...};
