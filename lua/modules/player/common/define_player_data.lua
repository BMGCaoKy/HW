local format = {}

format.baseInform = {
    time_create = os.time(os.date("!*t")),
    exp = {
        lv = 1,
        point = 0
    },
    candy = 0,
    item = {
        weapon = {
            gun = {
                equip = {
                    itemId = "gun_001",
                    img = "asset/weapon/icon/g2045_icon_bow_101.png",
                    name = "ui.gun_001",
                    
                },
                list = {
                    [1] = {
                        itemId = "gun_001",
                        img = "asset/weapon/icon/g2045_icon_bow_101.png",
                        name = "ui.gun_001",
                    }
                }
            },
            knife = {
                equip = {
                    itemId = "knife_001",
                    img="asset/weapon/icon/g2045_icon_staff_101.png",
                    name = "ui.knife_001",
                },
                list = {
                    [1] = {
                        itemId = "knife_001",
                        img="asset/weapon/icon/g2045_icon_staff_101.png",
                        name = "ui.knife_001",
                    }
                }
            }
        }
    },
    login7day = {
        lastLoginDay = 0, --lưu dạng time_date
        sumLoginDay = 0
    }
}

return format
