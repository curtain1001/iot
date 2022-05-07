package com.ruoyi.iot.device.message;

import javax.annotation.Nonnull;

import io.netty.buffer.ByteBuf;
import io.netty.buffer.Unpooled;

/**
 * @author zhouhao
 * @since 1.0.0
 */
public final class EmptyMessage implements org.jetlinks.core.message.codec.EncodedMessage {

	public static final EmptyMessage INSTANCE = new EmptyMessage();

	private EmptyMessage() {
	}

	@Nonnull
	@Override
	public ByteBuf getPayload() {
		return Unpooled.wrappedBuffer(new byte[0]);
	}

	@Override
	public String toString() {
		return "empty message";
	}
}
