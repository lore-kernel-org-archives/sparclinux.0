Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCED224AE8
	for <sparclinux@vger.kernel.org>; Fri,  9 Jan 2026 01:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767921317; cv=none; b=n5D3gl1k2+acGFrHeoLU2xk7m+edWO2b7PHKOm7B3k3XXQIw3HtKuilcJxfdzcjWDt6vfAREmVFOxDG8PqFpjFulGc3IopQ36odEASYCV+QS5TEcbyr1wSrYvMV9I/njqDlLP0D3ofYL/NLuo5BNsSllbf8UbJAf7FfO3yzDcx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767921317; c=relaxed/simple;
	bh=/UYwcca/uYassSpzopa4ccKEiuTLLHTgj+Tnt5mHcTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C4nsUeYAKnwrpDY3rUF0VflSFE25YI65q0qXXIvOHDOuHDAFs+YcaUC8p2CM3UaUcavV03B5z9LNm7MPWYjfKudPA3WyS9T+Eqie8TZPSl5hxJXt8LMtjY1Hs1nYweM+5go1pvKdAZz9NhaKC3eI0XC51WzgLpheLSml7uPR9gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E+8bWVwJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+8bWVwJ"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d3ba3a4deso22351365e9.2
        for <sparclinux@vger.kernel.org>; Thu, 08 Jan 2026 17:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767921311; x=1768526111; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eRVWHu/skVEevVui6ZpqPm1l4lhyEl80aGvSFHmLXP8=;
        b=E+8bWVwJ9gnXrV5TDiGTTr9pNCVi1piVoS85y9ztP8DON6oaIW+ddzswPRr4TmdK9u
         01GrCjiRKVlbQDLCcTCrKpYaniMPmhXX/0yZSu4bL4AEj2fSr51ZeJVavCVP0RAY8L6R
         dYX3QS8hJu/n7JFOxfANZWNyuWKYpusFdK3XEPm90oHuGUt4tfG2cxcEUPhS6hSkdWAh
         1q+F+CsNYETnyv1b2lLj1sE+r346YKxnH9L9VFftEBLNi6opr0oE34eWQofHCn3l/JGd
         AbUGOjLwDTt7S41hmKHEFPco3+20xEV5eG4bE5eRquKIyDEAteiY+C4F/fyIWeR/F7vm
         +M+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767921311; x=1768526111;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eRVWHu/skVEevVui6ZpqPm1l4lhyEl80aGvSFHmLXP8=;
        b=n2TXMns2kTgr12G7Wv3FJO+9XT8tP0DfCOMBgWTCpyMFI+bQfi/OYLDo97dTsFnVwY
         4zUnngyccw3eEODq7/wdJWVG+KA0oiDAihw6Ffpw04SHM9HYOdpqsIzeISxqX4urr7Mj
         4t5qbrWHDxq2iNlSQqCEPpsh7iQO5rYHgaKY5AQwIjxXNZ69bS67kDICv44Yv360xqas
         Iz4n6y0VK8pbzjHII2DT+HamEpiQaDe555ABLo8MllLVoDyd08zarsMLIa0mtpJ6pbUv
         2zmSzdgPZx/LzaTA2Fmnpl/yEdMk2T2dK4lPYPudhgR0hNeekdykgvh0Fu9UKDXQ3epx
         a8ug==
X-Gm-Message-State: AOJu0YzD6zautlc0V882IAx1W2zxnrZXNJrBLi55VQiGw7a8/HA7hiaw
	QVvEv0nA3QSphoB9bg6GOu47/ilZXw08/8SHL4KfQ2NSt354Wjqw3hst
X-Gm-Gg: AY/fxX5bGYWBjINNeMEOdukzy7qeEPV3UcyYuCFHDeN7pYkrd86MVGFkEpSOIYfj3v0
	msNT4Mi1lEP+uDBDfGxq5hsKgCWUa0tojVluL30gMvmtWJjRbrxARE5vToVum3y9lu5Bj6iKjVq
	CyuD1ogtgwDNN8E6KkbBZsh6MxHy3KlxAFBSnpc7BTszi4nQy0IEe42tehebXnEdMgAC/imskjp
	pjG3CTkgGJb07mHJWxwUboeOlTY1Lc6AMrbQMFK2PN5DTTEkF074f9Lb++TOJiwcD1ozV+X5W5d
	UnlMAyX+KD6tBHY3xJZ0bVMFCD/fUmSONyS/NcvgfZSumIQVLchhlWv5e/KfZkXZ03+ujwUVyN3
	DFd036xempBbRV8D2ZHerl6Y2Ti/+vAzsmUKuO7ABwJzAtqrXz6CNiaK7i416qmGqcNBK3g0Vh0
	g33ODR2bncbB+kLKOLg1E8ZsHOogEgzDot/w28dgV+WKMVmDt3pVXSnA==
X-Google-Smtp-Source: AGHT+IGFSa+uU6aJEju0Sdj/mJeUfKPv/sWSv3LFyI9MofUJwBdjz5lr9MbefJRWgFqBbosaiRcf4w==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr87829495e9.11.1767921310893;
        Thu, 08 Jan 2026 17:15:10 -0800 (PST)
Received: from ?IPV6:2a02:168:575a:f00d:d97:d735:6aa7:bddd? ([2a02:168:575a:f00d:d97:d735:6aa7:bddd])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-47d87167832sm52431725e9.7.2026.01.08.17.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jan 2026 17:15:09 -0800 (PST)
Message-ID: <fd2f7767-6c86-4796-acbe-7a30ef5d8adf@gmail.com>
Date: Fri, 9 Jan 2026 02:15:06 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Updated firefox package available for sparc64
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <cfe80c9b88601c65e1cc91104da23f7644fed48c.camel@physik.fu-berlin.de>
Content-Language: en-GB
From: Gregor Riepl <onitake@gmail.com>
Autocrypt: addr=onitake@gmail.com; keydata=
 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
 qAI1ww==
In-Reply-To: <cfe80c9b88601c65e1cc91104da23f7644fed48c.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Adrian,

Thanks a lot for that!

> I have successfully built and uploaded the latest version of the firefox package
> for sparc64. The package has been verified to work fine (see screenshot in [1]).

Unfortunately it segfaults very quickly on my Ultra 10:

#0  0xfffff80100e96444 in __pthread_kill_implementation (threadid=18446735281911764096, signo=11, no_tid=0) at ./nptl/pthread_kill.c:43
#1  0xfffff80100e436d4 in __GI_raise (sig=11) at ../sysdeps/posix/raise.c:26
#2  0xfffff80113549200 in nsProfileLock::FatalSignalHandler (signo=11, info=0x7feffe0e7b0, context=0x7feffe0e7b0) at ./toolkit/profile/nsProfileLock.cpp:177
#3  <signal handler called> () at ../sysdeps/unix/sysv/linux/sparc/sparc64/sigreturn_stub.S
#4  0xfffff80113715f94 in js::gc::Cell::storeBuffer (this=0x7801136dd874) at ./js/src/gc/Cell.h:365
#5  js::HeapSlot::post (this=0x12ff9c3f060, owner=0x12ff9c3f040, kind=js::HeapSlot::Slot, slot=1, target=<optimized out>) at ./js/src/gc/Barrier.h:997
#6  js::HeapSlot::init (v=<optimized out>, this=0x12ff9c3f060, owner=0x12ff9c3f040, kind=js::HeapSlot::Slot, slot=1) at ./js/src/gc/Barrier.h:962
#7  js::NativeObject::initFixedSlot (this=0x12ff9c3f040, slot=1, value=<optimized out>) at ./js/src/vm/NativeObject.h:1345
#8  JSFunction::initNative (this=0x12ff9c3f040, native=0xfffff801136dd874 <FunctionPrototype(JSContext*, unsigned int, JS::Value*)>, jitInfo=0x0) at ./js/src/vm/JSFunction.h:645
#9  js::NewFunctionWithProto
     (cx=<optimized out>, native=0xfffff801136dd874 <FunctionPrototype(JSContext*, unsigned int, JS::Value*)>, nargs=<optimized out>, flags=..., enclosingEnv=..., atom=..., proto=..., allocKind=js::gc::AllocKind::FUNCTION, newKind=js::TenuredObject) at ./js/src/vm/JSFunction.cpp:1810
#10 0xfffff80113716340 in CreateFunctionPrototype (cx=0x70000433e00, key=JSProto_Function) at ./js/src/vm/JSFunction.cpp:834
#11 0xfffff801136c75b4 in js::GlobalObject::resolveConstructor (cx=0x70000433e00, global=..., key=JSProto_Function, mode=<optimized out>) at ./js/src/vm/GlobalObject.cpp:351
#12 0xfffff8011374cb90 in js::GlobalObject::ensureConstructor (cx=0x70000433e00, global=..., key=JSProto_Function) at ./js/src/vm/GlobalObject.h:356
#13 CreateObjectConstructor (cx=0x70000433e00, key=JSProto_Object) at ./js/src/builtin/Object.cpp:2388
#14 0xfffff801136c75e4 in js::GlobalObject::resolveConstructor (cx=0x70000433e00, global=..., key=JSProto_Object, mode=<optimized out>) at ./js/src/vm/GlobalObject.cpp:369
#15 0xfffff801136c9088 in js::GlobalObject::ensureConstructor (cx=0x70000433e00, global=..., key=JSProto_Object) at ./js/src/vm/GlobalObject.h:356
#16 js::GlobalObject::new_
     (cx=0x70000433e00, clasp=0xfffff80118d18fb8 <SystemGlobal::GetJSClass()::klass>, principals=<optimized out>, hookOption=JS::DontFireOnNewGlobalHook, options=<optimized out>)
     at ./js/src/vm/GlobalObject.cpp:689
#17 0xfffff8010f9de1ec in xpc::CreateGlobalObject (cx=0x70000433e00, clasp=0xfffff80118d18fb8 <SystemGlobal::GetJSClass()::klass>, principal=0x70000254580, aOptions=...)
     at ./js/xpconnect/src/nsXPConnect.cpp:442
#18 0xfffff8010f9d23f8 in XPCWrappedNative::WrapNewGlobal (cx=0x70000433e00, nativeHelper=..., principal=0x70000254580, aOptions=..., wrappedGlobal=0x7feffe0f2f0)
     at ./js/xpconnect/src/XPCWrappedNative.cpp:184
#19 0xfffff8010f9e019c in xpc::InitClassesWithNewWrappedGlobal (aJSContext=0x70000433e00, aCOMObj=0x70000524600, aPrincipal=0x70000254580, aFlags=1, aOptions=..., aNewGlobal=...)
     at ./build-browser/dist/include/mozilla/RefPtr.h:470
#20 0xfffff8010f971ad0 in mozJSModuleLoader::CreateLoaderGlobal (this=0x700006cfe80, aCx=0x70000433e00, aLocation=..., aGlobal=...) at ./js/xpconnect/loader/mozJSModuleLoader.cpp:393
#21 0xfffff8010f971d48 in mozJSModuleLoader::InitSharedGlobal (this=0x700006cfe80, aCx=0x70000433e00) at ./build-browser/dist/include/js/RootingAPI.h:1254
#22 0xfffff8010f971eb0 in mozJSModuleLoader::InitStatics () at ./build-browser/dist/include/mozilla/StaticPtr.h:110
#23 0xfffff8010f9dd35c in nsXPConnect::InitJSContext () at ./js/xpconnect/src/nsXPConnect.cpp:99
#24 xpc::InitializeJSContext () at ./js/xpconnect/src/nsXPConnect.cpp:107

It was quite hard to get even a stack trace, because of excessive memory usage (gdb eats 4.5GB just for tracing a core dump, and the box only has 512MB).

I suspected that the crash was memory-related at first, but it looks like it might be an issue with the JS runtime? If it is in fact memory-related, I wonder why this would happen. There's plenty of swap space available.

Regards,
oni
