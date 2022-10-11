local format={}

format.baseInform={
    time_create=os.time(os.date("!*t")),
    exp={
        lv=1,
        point=0
    },
    item={
        weapon={
            gun={},
            knife={}
        }
    },
    login7day={
        lastLoginDay=0, --lưu dạng time_date
        sumLoginDay=0,
    }
}

return format