Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4B3DD85B
	for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 07:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177497; cv=none; b=cQFgr1SPozXcn3khrPgTfKBU7zlF0U+skZTK2UOnvpVQsOxLwV3CJgE8V5eFIdYXLmVBf677+gZ/tXe6FQkhzB5jkYPAUNcAqviqbdn3nmLYFERn8ke0Y4ceXMbyuyFbgp/qvao5DDMqqE6IwoQoG/bC+n34vaMwoRWiTd9pAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177497; c=relaxed/simple;
	bh=TZ0RN3qnNzUPKYI6sc0z1cZ1dFrGqG8XGPMWNd6bguI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dP/Ysa8SpjLIDLEIGNcNjO+W/AFPyDDiaePig8hvE1XL3YRgHhtybPwR8Lqi5MH1bkm0bcOlr8ZiwlUfRvIjhqOoINJK5IVg1Tnn2SF/8v3WckHvfmsfz7UdspkIbqfVojoVSdl2saJoyJEyFDTVaVa8avJM2K8GHqJACCwm/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e1euA8li; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e1euA8li"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1309f4ee97fso3540663c88.1
        for <sparclinux@vger.kernel.org>; Tue, 19 May 2026 00:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779177495; x=1779782295; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q7SDGHJz2p+KDEC7XABBWobKGkDCgsLu+7qpYk+YyVw=;
        b=e1euA8liJfTas6XGCEwfGRgeH0xFXl1TXyU8XHoyoVJtYgt+U3LPLopyyE5z1vabhE
         Dy8XUl6yyikuNlZDiuJMlqtoEPdOyEo5fHgon2kOgEU9WnN28ZgxdphW2hxmBfy2JN7U
         lb4YmKG+gzJG4IoLHXWpMuHUysbkPsSWIPtg+7P7lnXnRS+AWshqwFn+ufxQ5C3jm8Ln
         YGJD4pbeu8KhLK+jGqo9J8QAWnwUGjANK5LG1Q2W0vRYD0mL1Dw70TiyFc132sHjm1k5
         9NxeO+2xB9a3T+A2fFJ6F+54KsANN5We+5FguhE7uoL6gWmk5V3P7TzPb48+w7c+R67+
         LZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779177495; x=1779782295;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q7SDGHJz2p+KDEC7XABBWobKGkDCgsLu+7qpYk+YyVw=;
        b=GtsOgqBgWlnwiUtV19Hqfx0IyuX/J+TICpE6/U1h1yG5JmoQmGJPKCXnvNXanEE3pF
         LIV6dqoFTjZNunI+UhK3W5zi3mOD2ToSxCnVtcDjhzv59jKGVK7asjhJGsh98B5pg0q/
         49Rjw3xgXQk1/QcotoKiDpPWxze2x9lqayWh5IrwTw4sD3jmC2fTQz6u+FnLljZSFALn
         Eogtks1fetRUuuyqr3P6LrXGAUrzMbpLTiGSim2ieJdvZeF3q96EhK64JlnTKanguWk/
         eqSoURcP6DcgEx9KwdgQ/nQfVWRjtfZcYL7VuYwfJ3i8BCDBGTpfvwGSt2TI4ra2h1pX
         Au9A==
X-Forwarded-Encrypted: i=1; AFNElJ+9bb0nUC8nixxT/C8bpeWDafWmJuR5Bj3Rxj7wqJ21h5pEpMGbqOV0ttfALWzUVjdc05k4uW8bSDr9@vger.kernel.org
X-Gm-Message-State: AOJu0YyFcRVGxu/xxkZbe89KwCtSXDMydqlsw55PE+BCv3vs7rXLDPNO
	IsKpnI+yingJSNffZJbvJ6XwFtw2TSsAt01HByPvwLx6Y3+KRWVpb6QW
X-Gm-Gg: Acq92OE/6yVdPLSZ0JRA2dUGwGfXtCoTTE1ymGs38pKD/PhLOmv8jAtdAOXwuJpkqPN
	Cz+IAh5vKCa/ZO2VLRtvZ6V3AKepQa+dHfkMYNS3gxMIFDbZF70fHW9pt20pE0E56+i5U56zZ25
	gkVpat5fPdj/2kvlkwxmwHLVB2FsBYoUINBh2Bwaq/wn4hqwuYOgxGxvZzcBSbbs/5ixid/WUL1
	NNR1IQ1cc9RvqvT19fZRSi53MvLuUm5YYc6YTBWymlWQHNIeWmT1pwdxVQ5QOnq2JbfsmMxONQN
	5Irmxy1//+yhEe05oDg0GvH2xgpfcPeGGW+KQjzEKVl6nQ+PcCOevABNFyZ14/CnBypFLfQ+kZE
	4LmG/EbNxvynYoh3YABhUgAX9C5m39qADZTJDNT8DrHmY5QpYdt+JwksH6YppZQUCmJUbLggdRN
	EL0RZF6d407DRkrFfNcjF87L/AxA70eb1CyJra
X-Received: by 2002:a05:7022:6082:b0:12b:f616:1a4e with SMTP id a92af1059eb24-13504740a2fmr7096626c88.23.1779177494893;
        Tue, 19 May 2026 00:58:14 -0700 (PDT)
Received: from s7t7-debian-test.local ([67.170.89.46])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cf44668asm18768901c88.6.2026.05.19.00.58.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 00:58:14 -0700 (PDT)
From: Tony Rodriguez <unixpro1970@gmail.com>
To: davem@davemloft.net,
	sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	andreas@gaisler.com,
	thuth@redhat.com,
	regressions@lists.linux.dev,
	glaubitz@physik.fu-berlin.de,
	unixpro1970@gmail.com
Subject: [PATCH 0/1] sparc64: unify thread stack sizing and add explicit 32KB stack
Date: Tue, 19 May 2026 00:57:54 -0700
Message-ID: <20260519075809.8993-1-unixpro1970@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch fixes a reproducible stack exhaustion issue on SPARC64
that occurs during USB hub enumeration. This regression may have
started sometime after kernel v6.12. With the default 16KB kernel
stack, the following panic is triggered early in boot:

    [   25.528399] Call Trace:
    [   25.528403] [<0000000000433cd4>] dump_stack+0x8/0x18
    [   25.528419] [<00000000004297ac>] vpanic+0xdc/0x318
    [   25.528429] [<0000000000429a0c>] panic+0x24/0x30
    [   25.528436] [<0000000000be2280>] __schedule+0xa8/0x7bc
    [   25.528445] [<0000000000be2b60>] schedule+0x24/0x4c
    [   25.528452] [<0000000000be6970>] schedule_timeout+0xc8/0xe4
    [   25.528459] [<0000000000be3318>] __wait_for_common+0x78/0xf0
    [   25.528466] [<0000000000be3550>] wait_for_completion_timeout+0x1c/0x2c
    [   25.528473] [<000000001005e2f4>] usb_start_wait_urb+0x68/0x128 [usbcore]
    [   25.528502] [<000000001005e468>] usb_control_msg+0xb4/0xf8 [usbcore]
    [   25.528518] [<0000000010051180>] set_port_feature+0x44/0x54 [usbcore]
    [   25.528530] [<00000000100530f0>] hub_power_on+0xc8/0xe8 [usbcore]
    [   25.528543] [<0000000010054fd8>] hub_activate+0x12c/0x644 [usbcore]
    [   25.528557] [<0000000010059438>] hub_probe+0xdd4/0xeb0 [usbcore]
    [   25.528570] [<0000000010062360>] usb_probe_interface+0x234/0x26c [usbcore]
    [   25.528585] [<0000000000a10a40>] really_probe+0x1ac/0x3b0

This is caused by large SPARC64 trapframes, register-window spills,
and deep call paths in usbcore. A 16KB stack is insufficient for
this workload.

The new logic is:

    SPARC64:
        THREAD_SIZE = 4 * PAGE_SIZE (32KB)
        THREAD_SHIFT = PAGE_SHIFT + 2
        THREAD_SIZE_ORDER = 2

    Non‑SPARC64 with PAGE_SHIFT == 13:
        Retains the existing 16KB stack behavior

    Fallback:
        Retains the existing 8KB stack behavior

Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>


Tony Rodriguez (1):
  sparc64: unify thread stack sizing and add explicit 32KB stack

 arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

--
2.53.0

