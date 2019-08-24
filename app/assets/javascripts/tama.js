$(document).on("turbolinks:load", function() {
    $(function() {
        // 検索機能の表示制御の選択時
        $('.y_select select').change(function() {
            $(".y_search_item_name, .y_search_item_stock, .y_search_item_condition").css({
                "display":"none"
            });

            switch( $('.y_select select').val() ) {
                case "0":
                    $(".y_search_item_name").css({
                        "display":"block"
                    });

                    break
                case "1":
                    $(".y_search_item_stock").css({
                        "display":"block"
                    });
                    break
                case "2":
                    $(".y_search_item_condition").css({
                        "display":"block"
                    });
            }
        })

    })

    // 検索機能の表示制御の初回読み込み時
    $(".y_search_item_name, .y_search_item_stock, .y_search_item_condition").css({
        "display":"none"
    });

    switch( $('.y_select select').val() ) {
        case "0":
            $(".y_search_item_name").css({
                "display":"block"
            });

            break
        case "1":
            $(".y_search_item_stock").css({
                "display":"block"
            });
            break
        case "2":
            $(".y_search_item_condition").css({
                "display":"block"
            });
    }

    // ディスク番号および曲順の自動入力削除
    $(function() {
        let classCount = $(".y_disc").length;
        for (let i = 0 ; i < classCount; i++){
            $('.y_disc > input').eq(i).val(i+1)
            $('.y_disc_num').eq(i).text(i+1)
        }

        for (let i = 0 ; i < classCount; i++){
            let music_form_count = $('.y-nest').eq(i).find(".form-inline").length

            for (let j = 0 ; j < music_form_count; j++){
                $('.y-nest').eq(i).find('.y_music > input').eq(j).val(j+1)
                $('.y-nest').eq(i).find('.y_music_order').eq(j).text(j+1)
            }
        }

        $('.discs').on('cocoon:after-insert', function(e) {
            let classCount = $(".y_disc").length;
            for (let i = 0 ; i < classCount; i++){
                $('.y_disc > input').eq(i).val(i+1)
                $('.y_disc_num').eq(i).text(i+1)
            }

            for (let i = 0 ; i < classCount; i++){
                let music_form_count = $('.y-nest').eq(i).find(".form-inline").length

                for (let j = 0 ; j < music_form_count; j++){
                    $('.y-nest').eq(i).find('.y_music > input').eq(j).val(j+1)
                    $('.y-nest').eq(i).find('.y_music_order').eq(j).text(j+1)
                }
            }

        })

        $('.discs').on('cocoon:after-remove', function(e) {
            let classCount = $(".y_disc").length;
            for (let i = 0 ; i < classCount; i++){
                $('.y_disc > input').eq(i).val(i+1)
                $('.y_disc_num').eq(i).text(i+1)
            }

            for (let i = 0 ; i < classCount; i++){
                let music_form_count = $('.y-nest').eq(i).find(".form-inline").length

                for (let j = 0 ; j < music_form_count; j++){
                    $('.y-nest').eq(i).find('.y_music > input').eq(j).val(j+1)
                    $('.y-nest').eq(i).find('.y_music_order').eq(j).text(j+1)
                }
            }
        })

    })

    // 画像選択時にプレビュー表示
    $(function(){
        $('form').on('change', 'input[type="file"]', function(e) {
            let file = e.target.files[0],
                reader = new FileReader(),
                $upload_view = $(".y_upload_view")

            if(file.type.indexOf("image") < 0){
                return false;
            }



            reader.onload = (function(file) {
                return function(e) {
                    $(".y_image_file_name").text(file.name)
                    $upload_view.empty()
                    $upload_view.append($('<img>').attr({
                        src: e.target.result,
                        width: "256px",
                        height:"256px",
                        class: "upload_view",
                        title: file.name
                    }))
                }
            })(file)

            reader.readAsDataURL(file)
        })
    })

    // 半角数字に変換
    $(function(){
        $('.input_number_only').on('input', function(e) {
            let value = $(e.currentTarget).val().substr(0,7);
            value = value
                .replace(/[０-９]/g, function(s) {
                    return String.fromCharCode(s.charCodeAt(0) - 65248);
                })
                .replace(/[^0-9]/g, '');
            if (value.length === 1) {
                if (value.match(/[0]/g)) {
                    $(e.currentTarget).val("")
                } else {
                    $(e.currentTarget).val(Number(value))
                    $(".y_task_price").text(Math.ceil(Number(value)*1.08))
                }
            }else{
                $(e.currentTarget).val(Number(value))
                $(".y_task_price").text(Math.ceil(Number(value)*1.08))
            }
        });
    });

    $(function(){
        $('.y_plus').on('click', function(e) {
            let displayTargetClass = ".quantity" + e.toElement.classList['1']
            let saveTargetClass = ".purchase_quantity" + e.toElement.classList['1']
            let stockTargetClass = ".stock" + e.toElement.classList['1']

            let stock = parseInt($(stockTargetClass).text())
            let quantity = parseInt($(displayTargetClass).text())

            //在庫が0の場合と要求数が在庫より多い場合に在庫の最大値に合わせる
            if(stock <= quantity || stock === 0){
                quantity = stock - 1
            }

            $(displayTargetClass).text(quantity+1)
            $(saveTargetClass).val(quantity+1)

        });

        $('.y_minus').on('click', function(e) {
            let displayTargetClass = ".quantity" + e.toElement.classList['1']
            let saveTargetClass = ".purchase_quantity" + e.toElement.classList['1']
            let stockTargetClass = ".stock" + e.toElement.classList['1']

            let stock = parseInt($(stockTargetClass).text())
            let quantity = parseInt($(displayTargetClass).text())


            if(stock < quantity || stock === 0){
                quantity = stock + 1
            }

            //以下にならないように修正
            if(quantity === 0){
                $(displayTargetClass).text(0)
                $(saveTargetClass).val(0)
            }else{
                $(displayTargetClass).text(quantity-1)
                $(saveTargetClass).val(quantity-1)
            }
        });
    });

})

