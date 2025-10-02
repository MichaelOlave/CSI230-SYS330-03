function ScrapePage() {
    $scraped_page = Invoke-WebRequest -Uri http://localhost/ToBeScraped.html
    
    $scraped_page.Length
    
    $scraped_page.Links
    
    $scraped_page.Links | Select-Object href
    
    $h2s = $scraped_page.ParsedHtml.body.getElementsByTagName("h2") | ForEach-Object { $_.outerText }
    
    $h2s
    
    $divs1 = $scraped_page.ParsedHtml.body.getElementsByTagName("div") | Where-Object { $_.getAttributeNode("class").nodeValue -ilike "div-1" } | Select-Object innerText
    
    $divs1
}

function gatherClasses() {
    $page = Invoke-WebRequest -TimeoutSec 2 http://localhost/Courses.html

    $trs = $page.ParsedHtml.body.getElementsByTagName("tr")

    $FullTable = @()
    for ($i = 0; $i -lt $trs.Length; $i++) {
        $tds = $trs[$i].getElementsByTagName("td")
        # I added this if statment becuase i was getting an error saying you cant split a null object -- Michael Olave
        if ($tds.Length -gt 8) {
            $Times = $tds[5].innerText.split("-")
            $FullTable += [PSCustomObject]@{
                "Class Code" = $tds[0].innerText;
                "Title"      = $tds[1].innerText;
                "Days"       = $tds[4].innerText;
                "Time Start" = $Times[0];
                "Time End"   = $Times[1];
                "Instructor" = $tds[6].innerText;
                "Location"   = $tds[9].innerText;
            }
        }
    }
    return $FullTable
}

function daysTranslator($FullTable) {
    
    for ($i = 0; $i -lt $FullTable.Length; $i++) {
        $Days = @()
        if ($FullTable[$i].Days -ilike "*M*") { $Days += "Monday" }
        if ($FullTable[$i].Days -ilike "*T[^h]*") { $Days += "Tuesday" }
        ElseIf ($FullTable[$i].Days -ilike "T") { $Days += "Tuesday" }
        if ($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }
        if ($FullTable[$i].Days -ilike "*TH*") { $Days += "Thursday" }
        if ($FullTable[$i].Days -ilike "*F*") { $Days += "Friday" }

        $FullTable[$i].Days = $Days
    }
    return $FullTable
}