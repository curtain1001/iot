package net.pingfang.iot.core.network.security;

import reactor.core.publisher.Mono;

/**
 * 证书管理接口
 *
 * @author zhouhao
 */
public interface CertificateManager {

	Mono<Certificate> getCertificate(String id);

}
