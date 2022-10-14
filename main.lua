local function getRandomItem(items)
    local p=0
    p = math.random(1,100)
    print("ramdom: ",p)
    local cumulativeProbability = 0
    for name, item in pairs(items) do
      cumulativeProbability = cumulativeProbability + item.probability
      if p <= cumulativeProbability then
        return name, item.uid
      end
    end
  end



  item={
    k={
        uid=1,
        probability=20
    },
    v={
        uid=2,
        probability=20
    },
    q={
        uid=3,
        probability=20
    },
    w={
        uid=4,
        probability=25
    },
    g={
        uid=5,
        probability=20
    },
  }

  name, uid=getRandomItem(item)

  print(name,uid)