<?php
$conn = mysqli_connect("localhost", "root", "", "mydb");
?>

<html lang="hu">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Termek</title>
    <link rel="stylesheet" href="./style.css?3">
</head>

<body>
    <h1>Jakab Tamás Zoltán, Neptun: K8PQGI</h1>
    <table>
        <tr>
            <th>Épület</th>                                                    <!--oszlopok nevei-->
            <th>Termek száma</th>
            <th>Összes férőhely</th>
        </tr>
        <?php
            if(isset($_GET) && isset($_GET["Nmin"]))                             //'".$_GET["num"]."'
            {
                $data = mysqli_query(
                    $conn, "select epulet.nev as 'Épület', count(terem.id) as 'Termek száma', sum(terem.ferohely) as 'Összes férőhely' from terem
                    inner join epulet on terem.Epulet_ID = epulet.id
                    group by epulet.nev
                    having sum(terem.ferohely) > ".$_GET["Nmin"]."
                    order by epulet.nev ASC;"                                                   //insert lekérdezés                      
                    );


                while($row = mysqli_fetch_assoc($data))
                {
                    ?>
                    <tr>
                        <td><?php echo $row["Épület"];?></td>             <!--mit akarunk kiírni? as utáni cucc-->
                        <td><?php print $row["Termek száma"];?></td>
                        <td><?php print $row["Összes férőhely"];?></td>
                    </tr>
            <?php
                }
            }
            ?>
        </table>
</body>
</html>