import Prelude


get_Strs :: String ->[String]
get_Strs str =  case dropWhile (== '\n') str of
				"" -> []
				s' -> w : get_Strs s''
					where (w, s'') = break (== '\n') s'
					
toInt :: [String] -> [Int]
toInt lis = [read x :: Int | x <- lis]

qsort :: Ord a => [a] -> [a]
qsort [] = []
qsort (x:xs) =
    let smallPart = qsort [a | a <- xs, a <= x]
        bigPart = qsort [a | a <- xs, a > x]
    in smallPart ++ [x] ++ bigPart

main = do
	let rpath = "../../data/in.txt"
	file <- readFile rpath
	let arr = toInt (get_Strs file)
	let len = length arr :: Int
	let len1 = div len 2
	let arr1 = qsort arr
	let arr2 = drop len1 arr1
	let arr3 = take 10 arr2
	print arr3








