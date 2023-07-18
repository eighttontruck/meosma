package com.spring.javaweb11S.test;

import org.springframework.beans.factory.annotation.Autowired;

import com.spring.javaweb11S.dao.MemberDAO;
import com.spring.javaweb11S.service.MemberService;
import com.spring.javaweb11S.service.MemberServiceImpl;
import com.spring.javaweb11S.vo.MemberVO;

public class Test {
	@Autowired
	static
	MemberService memberService;
	public static void main(String[] args) {
		
//		final File driverFile = new File("src/main/resources/bin/chromedriver");
//		final String driverFilePath = driverFile.getAbsolutePath();
//		if(!driverFile.exists()&&driverFile.isFile()) {
//			throw new RuntimeException("not found file. or this is not file"+driverFilePath);
//		}
		
//		final ChromeDriverService service;
//		service = new ChromeDriverService.Builder().usingDriverExecutable(driverFile).usingAnyFreePort().build();
//		ChromeOptions options = new ChromeOptions();
////		//브라우저가 눈에 보이지 않고 내부적으로 돈다.
////		//설정하지 않을 시 실제 크롬 창이 생성되고, 어떤 순서로 진행되는지 확인할 수 있다.
//		options.addArguments("headless");
		
		//위에서 설정한 옵션은 담은 드라이버 객체 생성
		//옵션을 설정하지 않았을 때에는 생략 가능하다.
		//WebDriver객체가 곧 하나의 브라우저 창이라 생각한다.
//		
//		try {
////			service.start();
//		} catch(IOException e1) {
//			e1.printStackTrace();
//		}
		
		//final WebDriver driver = new ChromeDriver(options);
//		final WebDriver driver =  new ChromeDriver(service);
//		final WebDriverWait wait = new WebDriverWait(driver, 10);
		
		try {
//			driver.get("https://www.worksout.co.kr/brand/418?genderCodes=M");
//			Thread.sleep(5000);
//			
//			JavascriptExecutor js = (JavascriptExecutor) driver;
//            while (true) {
//                long initialHeight = (long) js.executeScript("return document.documentElement.scrollHeight");
//                js.executeScript("window.scrollTo(0, document.documentElement.scrollHeight);");
//                Thread.sleep(5000); // 잠시 대기하여 새로운 콘텐츠가 로드되도록 합니다.
//                long newHeight = (long) js.executeScript("return document.documentElement.scrollHeight");
//                // 스크롤이 더 이상 진행되지 않을 때 반복문 종료
//                if (newHeight == initialHeight) {
//                    break;
//                }
//            }
			//driver.get("https://www.naver.com/");
			//WebElement el2 = driver.findElement(By.className("h-28 flex justify-between"));
			
//			List<WebElement> el4 =driver.findElements(By.className("brandNm"));
//			List<WebElement> el3 =driver.findElements(By.className("item_name"));
//			List<WebElement> el5 =driver.findElements(By.className("item_name"));
//			List<WebElement> el4 =driver.findElements(By.cssSelector("div.text-12.leading-tight > p.uppercase"));
//			List<WebElement> el5 =driver.findElements(By.cssSelector("div.text-12.leading-tight > p.font-normal"));
//			List<WebElement> el6 =driver.findElements(By.cssSelector("div.text-12.leading-tight > div"));
// 			driver.findElement(By.name("q")).sendKeys("cheese" + Keys.ENTER);
//			final WebElement firstResult = wait.until(presenceOfElementLocated(By.cssSelector("h3>div")));
//	        System.out.println(firstResult.getAttribute("textContent"));
			
			
			MemberService memberService=new MemberServiceImpl();
//			for(int i=0;i<el5.size(); i++) {
//				System.out.println(el4.get(i).getText()+"/"+el5.get(i).getText()+"/"+el6.get(i).getText());
//				String brand=el4.get(i).getText();
//				String name=el5.get(i).getText();
//				String price=el6.get(i).getText();
//				price=price.replaceAll(",", "");
//				price=price.replaceAll("원", "");
//				System.out.println(price);
//				memberService.setInsertProduct(brand,name,Integer.parseInt(price),"남자","JA");
//			}
	    } catch (Exception e2) {
	        e2.printStackTrace();
	    } finally {
	        // 프로그램이 종료되면 resource 해제
//	        driver.quit();
//	        service.stop();
	    }
	}
}
