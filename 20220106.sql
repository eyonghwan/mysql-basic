-- 권한 뺏기
-- GRANT가 들어갈 자리에 REVOKE를 사용하면 됩니다.
-- 단, REVOKE는 GRANT와 TO FROM과 연동해서 씁니다.
-- REVOKE 권한명... ON DB명.테이블명 FROM 계정명;


-- [조인(JOIN)]
-- 테이블 2개를 합쳐주는 기능
-- 연관된 데이터를 여러 테이블에 나눠담았을 때
-- 그것을 다시 재조립해줍니다.
-- 조인 문법
-- SELECT 테이블1.컬럼1, 테이블.컬럼2, 테이블2.컬럼1, 테이블2.컬럼2...
-- 			FROM 테이블1 조인구문 테이블2
--          ON 테이블1.공톨컬럼 = 테이블2.공통컬럼;
--          WHERE구문은 ON으로 함쳐진 결과컬럼에 대한 필터링을 해줍니다.
use ict_practice;
SELECT * FROM buytbl INNER JOIN usertbl ON buytbl.user_id = usertbl.user_id;
SELECT * FROM usertbl;
SELECT * FROM buytbl;

-- 지금 현재 구매자 정보를 조회하려고 하는데, 필요한 정보는
-- buytbl의 구매 물품정보 전체에, 구매자 정보는 택배를 받기 위해서
-- 이름, 주소, 휴대폰번호만 있으면 되는 상황입니다.
-- 조인구문을 활용해 필요한 컬럼만 출력되게 수정해주세요.
SELECT buytbl.order_number, buytbl.user_id, buytbl.prod_name,
    buytbl.group_name, buytbl.price, buytbl.amount,
    usertbl.user_name, usertbl.addr, usertbl.phone_number 
	FROM buytbl INNER JOIN usertbl ON buytbl.user_id = usertbl.user_id;


-- 위의 경우처럼 특정 테이블의 전체 데이터를 출력하는 경우는
-- 테이블명.*로 대체할 수 있습니다.
SELECT buytbl.*, usertbl.user_name, usertbl.addr, usertbl.phone_number 
       FROM buytbl INNER JOIN usertbl ON buytbl.user_id = usertbl.user_id;

-- FROM구문에서 테이블명만 적는게 아니라, 테이블명 별명 형식으로 적을 경우는
-- 테이블명을 다 적지 않고 별명으로 대체해서 호출할 수 있어 좀 더 편리합니다.
-- 현재 *로 처리된 부분을
-- buytbl의 구매 물품정보 전체에, 구매자 정보는 택배를 받기 위해서
-- 이름, 주소, 휴대폰번호만 있으면 되는 상황입니다.
-- 위에 적힌 컬럼조회하는 부분으로 고쳐주세요(단, buytbl.*에 해당하는 구문은 쓰지마세요.)
SELECT b.order_number, b.user_id, b.prod_name,
	   b.group_name, b.price, b.amount,
	   u.user_id, u.addr, u.phone_number
	   FROM buytbl b INNER JOIN usertbl u 
	   ON b.user_id = u.user_id;

-- WHERE절은 먼저 JOIN구문의 결과가 나온 상태에서, 추가 필터링만을 담당합니다.
-- 구매물품의 가경이 50000원 이상인 것만 남기는 구문.
SELECT b.order_number, b.user_id, b.prod_name,
	   b.group_name, b.price, b.amount,
	   u.user_id, u.addr, u.phone_number
	   FROM buytbl b INNER JOIN usertbl u 
	   ON b.user_id = u.user_id
       WHERE price >= 50000;
-- 위쪽 JOIN구문을 활용하시되, 가격이 200000원 이하인 품목만 남겨주시고
-- 그 남은 자료들을 가격순으로 내림차순 출력해주세요. ORDER BY 내림차순;
SELECT b.order_number, b.user_id, b.prod_name,
	   b.group_name, b.price, b.amount,
	   u.user_id, u.addr, u.phone_number
	   FROM buytbl b INNER JOIN usertbl u 
	   ON b.user_id = u.user_id
       WHERE price <= 200000
       ORDER BY price DESC;

-- LEFT JOIN, RIGHT JOIN은 공통 데이터가 아닌 데이터도 방향에 따라
-- 출력이 되기 째문에 공통데이터(INNER)가 아닌 데이터(OUTER)까지
-- 출력되는 점을 이용해 OUTER JOIN이라고 부릅니다.
-- LEFT OUTER JOIN은 JOIN구문의 왼쪽 테이블의 자료는 모두 출력하고
-- 오른쪽 테이블 데이터는 왼쪽 기준컬럼과 일치할 때만 출력합니다.
-- 반대로 RIGHT OUTER JOIN은 join 구문의 오른쪽 테이블의 자료는 전부 출력하고
-- 왼쪽 테이블 데이터는 오른쪽 테이블의 기준컬럼과 일치할 때만 출력합니다.
SELECT * FROM usertbl; -- 가입회원은 11명
SELECT * FROM buytbl; -- 구매이력이 있는 회원은 5명

-- LEFT JOIN인데, usertbl을 LEFT에, buytbl을 RIGHT에 두고 작성해주세요.
-- INNER JOIN을 넣은 자리에 대신 LEFT OUTER JOIN으로 고쳐주시기만 하면 작동합니다.
-- 테이블의 컬럼은 전체 출력합니다.
SELECT * FROM usertbl LEFT OUTER JOIN buytbl
		ON usertbl.user_id = buytbl.user_id;

-- RIGHT JOIN인데, usertbl을 RIGHT에, buytbl을 LEFT에 두고 작성해주세요.
-- INNER JOIN을 넣은 자리에 대신 RIGHT OUTER JOIN으로 고쳐주시기만 하면 작동합니다.
-- 테이블의 컬럼은 전체 출력합니다.
SELECT * FROM buytbl RIGHT OUTER JOIN usertbl
		ON buytbl.user_id = usertbl.user_id;

-- FULL OUTER JOIN은 누락 데이터 없이 양쪾 테이블의 모든 자료를 보여줍니다.
-- ORACLE SQL에는 FULL OUTER JOIN을 구문으로 지원하지만 MYSQL에서는
-- FULL OUTER JOIN을 UNION 명령어를 이용해
-- LEFT OUTER JOIN과 RIGHT OUTER JOIN의 결과물을 합쳐서 구현합니다.
-- 이 때 접점이 없는 데이터는 반대쪽 데이터를 NULL로 가집니다.
-- UNION은 위쪽 결과물과 아래쪽 결과물을 합쳐줍니다.
SELECT * FROM buytbl b LEFT OUTER JOIN usertbl u ON b.user_id = u.user_id
		UNION -- UNION구문은 위 아래 결과 화면을 합쳐줍니다. (LEFT 와 RIGHT사이에 넣으면 FULL OUTER JOIN)
SELECT * FROM buytbl b RIGHT OUTER JOIN usertbl u ON b.user_id = u.user_id;

-- FULL OUTER JOIN 이해를 돕기 위한 추가 데이터 설정
CREATE TABLE student(
	user_name varchar(3) PRIMARY KEY,
    user_addr char(2) NOT NULL
);

CREATE TABLE membership(
	user_name varchar(3) PRIMARY KEY,
    user_point INT NOT NULL
);

INSERT INTO student VALUES('강건마', '서울');
INSERT INTO student VALUES('노영웅', '서울');
INSERT INTO student VALUES('이상용', '서울');
SELECT * FROM student;

INSERT INTO membership VALUES('강건마', 15000);
INSERT INTO membership VALUES('노영웅', 37000);
INSERT INTO membership VALUES('김철수', 500);
SELECT * FROM membership;

-- 위 데이터셋(학생 student, 회원포인드 membership) 에 대해 LEFT JOIN해 주세요.
-- 아래 구문을 FULL OUTER JOIN
SELECT * FROM student s LEFT OUTER JOIN membership m ON s.user_name = m.user_name
	UNION
SELECT * FROM student s RIGHT OUTER JOIN membership m ON s.user_name = m.user_name;

-- 위의 UNION으로 처리되는 구문은 user_name이 두 번 출력되는 문제가 있습니다.
-- 한 번만 출력되게 만들어보세요.

SELECT s.user_name, s.user_addr, m.user_point FROM student s LEFT OUTER JOIN membership m ON s.user_name = m.user_name
	UNION
SELECT m.user_name, s.user_addr, m.user_point FROM student s RIGHT OUTER JOIN membership m ON s.user_name = m.user_name;



