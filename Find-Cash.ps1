function roundTo5 {
    param($amount)
    $diff = $amount % 5;
    if ($diff -gt 2) {
        return $amount + (5 - $diff);
    } 
    return $amount - $diff;
}

function intToCash {
    param([String]$num)
    if ($num.Length -le 2) {
        return "0." + $num;
    }
    return $num.Insert($num.length - 2, '.');
}

function cashToInt {
    param([String]$cash)
    if ($cash.length -gt 3 -and !($cash.Substring(0, $cash.Length-3) -Match "\D")`
        -and ($cash[-3] -eq '.' -or $cash[-3] -eq ',')) {
        return [Int]$cash = $cash -replace "[^0-9]" , '';
    }
    return -1;
}


function question {
    $customerPays = Get-Random 500, 1000, 2000, 5000, 10000, 20000;
    $customerOwes = Get-Random -Min 5 -Max $customerPays;
    $correct = roundTo5($customerPays - $customerOwes);

    Write-Host "Customer pays with  : Euro $(intToCash($customerPays))";
    Write-Host "Customer has to pay : Euro $(intToCash($customerOwes))";
    Write-Host "Customer's change   : Euro " -NoNewline;

    [String]$answer = roundTo5(cashToInt(Read-Host));

    if ($answer -eq [String]$correct) {
        Write-Host "Correct!";
    } else {
        Write-Host "Incorrect!";
    }
}

question;
