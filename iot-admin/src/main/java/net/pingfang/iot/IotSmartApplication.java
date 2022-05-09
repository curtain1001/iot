package net.pingfang.iot;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.boot.web.servlet.ServletComponentScan;

/**
 * 启动程序
 *
 * @author ruoyi
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class }, scanBasePackages = "net.pingfang.*")
@ServletComponentScan
public class IotSmartApplication {
	public static void main(String[] args) {
		// System.setProperty("spring.devtools.restart.enabled", "false");
		SpringApplication.run(IotSmartApplication.class, args);
		System.out.println("                               _                            _   \n"
				+ "                              (_)                          | |             \n"
				+ "__      ___   _ _ __ ___   ___ _   ___ _ __ ___   __ _ _ __| |_            \n"
				+ "\\ \\ /\\ / / | | | '_ ` _ \\ / _ \\ | / __| '_ ` _ \\ / _` | '__| __|     \n"
				+ " \\ V  V /| |_| | | | | | |  __/ | \\__ \\ | | | | | (_| | |  | |_         \n"
				+ "  \\_/\\_/  \\__,_|_| |_| |_|\\___|_| |___/_| |_| |_|\\__,_|_|   \\__|     \n");
		System.out.println(" ----------开源生活物联网平台-----------\n" + " =========wumei-smart启动成功=========\n");
	}
}
