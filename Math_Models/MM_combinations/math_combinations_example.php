<?php

include_once($_SERVER['DOCUMENT_ROOT'] . "/config.php");
require_once ('math_combinations.php');

$combinatorics = new Math_Combinatorics;
/*$set = array(
    'one'   => 'a',
    'two'   => 'b',
    'three' => 'c',
    'four'  => 'd'
    );
*/

$set = array(
	'Ohrid' => '41.112664, 20.799444',
	'Ljubanista' => '40.921801,20.768533',
	'Trpejca' => '40.960480,20.782944',
	'Elshani' => '41.026444,20.815178'
	);

//$set = ['A','B','C','D'];

$combinations = $combinatorics->combinations($set, 2);
$combinations_ = $combinations;
$permutations = $combinatorics->permutations($set, 2);

foreach($combinations as $key=>$value) {
	$tmp = array();
	$tmp = array_values($combinations[$key]);
	$distance_tot_one_way = 0;
	
	//foreach($tmp AS $keytmp=>$valuetmp) {
	for($i=0; $i<count($tmp)-1; $i++) {	
		list($lat1, $lng1) = explode(',', $tmp[$i]);
		list($lat2, $lng2) = explode(',', $tmp[$i+1]);
		$distance_tot_one_way += helper::get_distance_Haversine($lat1, $lng1, $lat2, $lng2);	
	}
	//print_r($tmp);
	//list($lat1, $lng1) = explode(',', $tmp[0]);
	//list($lat2, $lng2) = explode(',', $tmp[1]);
	
	$combinations_[$key]['distance'] = $distance_tot_one_way;
	
}

print_r($combinations_);


?>