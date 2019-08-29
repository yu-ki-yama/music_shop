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

    //+-のボタンカウンター
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

    //住所選択時に非同期で住所を選択住所に変更
    $(function(){
        $('.y_purchases_address_select > select').on('change', function(e) {
            const delimit = function(n) {
                return String(n).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,');
            }
            let target_select_id = e.target.id
            let select_num = $("#" + target_select_id)[0].selectedIndex

            $.ajax({
                type:'GET',
                url: '/end_purchases',
                data: {num: select_num},
                dataType: 'json'

            }).done(function(data){
                // レスポンス内容に書き換える
                $("." + target_select_id + " > span")[0].innerHTML = data["name"]
                $("." + target_select_id + " > span")[1].innerHTML = data["postal_code"]
                $("." + target_select_id + " > span")[2].innerHTML = data["address"]
                $("." + target_select_id + " > .y_purchases_address_tel > span")[0].innerHTML = data["telephone_number"]

                // 選択されてることなる住所の数を計算
                counter = {}
                for( let i = 0 ; i < $(".y_purchases_address_select > select").length; i++ ){
                    counter[$(".y_purchases_address_select > select")[i].options.selectedIndex] = true
                }
                Object.keys(counter).length
                $(".y_postage").text(delimit(500 * Object.keys(counter).length))
                $(".y_total_price").text(delimit(500 * Object.keys(counter).length + Number($(".y_all_price").text().replace(/,/g, ''))))



            }).fail(function(){
                alert('住所情報の取得に失敗しました')

                $("." + target_select_id + " > span")[0].innerHTML = '住所情報の取得に失敗しました'
                $("." + target_select_id + " > span")[1].innerHTML = '住所情報の取得に失敗しました'
                $("." + target_select_id + " > span")[2].innerHTML = '住所情報の取得に失敗しました'
                $("." + target_select_id + " > .y_purchases_address_tel > span")[0].innerHTML = '住所情報の取得に失敗しました'

                // 選択されてることなる住所の数を計算
                counter = {}
                for( let i = 0 ; i < $(".y_purchases_address_select > select").length; i++ ){
                    counter[$(".y_purchases_address_select > select")[i].options.selectedIndex] = true
                }
                Object.keys(counter).length
                $(".y_postage").text(delimit(500 * Object.keys(counter).length))
                $(".y_total_price").text(delimit(500 * Object.keys(counter).length + Number($(".y_all_price").text().replace(/,/g, ''))))
            })
        });

        $(function(){
            $(function(){
                $('.shipping_status_check').on('click', function(e) {
                    if( !confirm("発送済になりますがよろしいでしょうか？")　== true ) {
                        alert("取り消しました");
                        return false
                    }
                });
            });
        });

        $(function(){
            $(function(){
                $('.delete_check').on('click', function(e) {
                    if( !confirm("削除しますがよろしいでしょうか？")　== true ) {
                        alert("取り消しました");
                        return false
                    }
                });
            });
        });



    });
})

