<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>������ ��Ŀ ǥ���ϱ�</title>
    
</head>
<body>
<div id="map" style="width:100%;height:850px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=6982ec2fbe848ee9b8f2b2f85a52f9bb"></script>
<script>
var mapContainer = document.getElementById('map'), // ������ ǥ���� div  
    mapOption = { 
        center: new kakao.maps.LatLng(33.450701, 126.570667), // ������ �߽���ǥ
        level: 1 // ������ Ȯ�� ����
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // ������ �����մϴ�
 // �Ϲ� ������ ��ī�̺�� ���� Ÿ���� ��ȯ�� �� �ִ� ����Ÿ�� ��Ʈ���� �����մϴ�
var mapTypeControl = new kakao.maps.MapTypeControl();
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

map.setMapTypeId(kakao.maps.MapTypeId.HYBRID);    
 
// ���� Ȯ�� ��Ҹ� ������ �� �ִ�  �� ��Ʈ���� �����մϴ�
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

// ��Ŀ�� ǥ���� ��ġ�� title ��ü �迭�Դϴ� 
var positions = [
    {
        title: 'īī��', 
        latlng: new kakao.maps.LatLng(33.450705, 126.570677)
    },
    {
        title: '���¿���', 
        latlng: new kakao.maps.LatLng(33.450705, 126.570777)
    },
    {
        title: '�Թ�', 
        latlng: new kakao.maps.LatLng(33.450705, 126.570877)
    },
    {
        title: '�ٸ�����',
        latlng: new kakao.maps.LatLng(33.450705, 126.570977)
    }
];

// ��Ŀ �̹����� �̹��� �ּ��Դϴ�
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // ��Ŀ �̹����� �̹��� ũ�� �Դϴ�
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // ��Ŀ �̹����� �����մϴ�    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // ��Ŀ�� �����մϴ�
    var marker = new kakao.maps.Marker({
        map: map, // ��Ŀ�� ǥ���� ����
        position: positions[i].latlng, // ��Ŀ�� ǥ���� ��ġ
        title : positions[i].title, // ��Ŀ�� Ÿ��Ʋ, ��Ŀ�� ���콺�� �ø��� Ÿ��Ʋ�� ǥ�õ˴ϴ�
        image : markerImage // ��Ŀ �̹��� 
    });
}
</script>
</body>
</html>