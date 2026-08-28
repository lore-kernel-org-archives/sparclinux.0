Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6C33DDB1E
	for <sparclinux@vger.kernel.org>; Fri, 28 Aug 2026 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787903091; cv=none; b=hKxrAoSzO76sA39R4NU6ykLH7EbOu+M0bZddMSZMMRu8PxqYadTm16a91xpWiJhJo3YHqQk9ncF+b1Ns6EA6/SrActMbyt9o6wIXLfTOna/0UFosxPXb9xFr4mZ7uR7c8wQNBI77RGKaS+yj+GWdwYhyIH7l882Og5ysDE+8C4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787903091; c=relaxed/simple;
	bh=yqtH/41dsXx5wuA0PjmkoTksoAaMP1J2O+yM7Uazy18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=csXFVZgXorrWAfbI9Lob4LbxLpjJKvVl4Yt+obuzV6CFzy7eo3+aYH0+ihuQnXaLnlIt/22ECg+4i3fXyN8zRvsEbHI9oGEFCumcxEZHQ7VpEu1rz54Pph5OSEBUlONHduRC0D9e5hZxsM3cSZ+JoA9xarRYq27JGro9Cnuic/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iz4YcG7N; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iz4YcG7N"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c2544ff970dso82769066b.2
        for <sparclinux@vger.kernel.org>; Fri, 28 Aug 2026 00:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787903088; x=1788507888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yqtH/41dsXx5wuA0PjmkoTksoAaMP1J2O+yM7Uazy18=;
        b=iz4YcG7N7adjg4NyAzaqBtSXFDCnJujqXgfgoRxCsWhay2n+EZgHBokTJ8w5KoGQWt
         kI0alGdjKRyOw9oGPenhPcHsydZ15ecsizN95mwgfagAwEGnadw8nuAqZ+fysdAzhf1P
         dpgvvk2KBDEMT0/A+pifIPj3erz1AWkKGXTuC16BHxryaZ2sCuKfnmAcr1/vs+/MwlIF
         Dy/+pZzlNZbfabD0R9f1NwPHfjG7ohWIlEp7PuCJHuKJ5vqDt/PxMipEpE0qFIAiIESs
         yG4sWSROvA07K/D8IvTENmBawa5lb7B9y4wivS7/bl9bUacw/joDGORzRgAT23iiXvTn
         CAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787903088; x=1788507888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yqtH/41dsXx5wuA0PjmkoTksoAaMP1J2O+yM7Uazy18=;
        b=f8whEFTNJ9b/Qd83sz4iJVKV8FvOsWFVb2G7ulso4f8QlTH3lpUBGXPaPGxI0Bso1N
         f6u0ocbPDBXcD8yHPnsz6f1myYDL0xe+lFd+bfIF0Cm/iDBzmDQvvczpbDFxWVf/mXPY
         SCS59JDDMUhtwtLWBS00hlyatGvKPR0idtK5oBwXM39l54C2e2+0SpowAkCR7cx2QTWD
         +eSZx2ouKB8priGeOjbd+64z7bCHqZyCeuz0ypjwdLWbpwKSewPGzeaLU3jYNWV8zpcE
         I8m0UVZgv+emJgoandY6XtMDBTHw4Rq+AqLmNBOvpMSdEevCIQ8Q9ViUO0OO3Np4acHn
         5LPQ==
X-Gm-Message-State: AFuF++nIxoX5B/RQwqgZcAuLycgr4/VyOZ/LxGK0TRLuIIIzgHAIudAL
	Os8H2wsRYRF9b42h5w1BXtjb7Gg9DYTIiQ7M/XMK7Hwg1vuNmhUE0G5vxXf/vmm7
X-Gm-Gg: AR+sD10aNA3Gms6nFAb0aRA9KdQNgPypUcqAasDkZ3NLMo2gZM/6aExJgBeLWxwPmp2
	b5CT5ivI3z6Uo5gWSHlpGnSVsQ3YbiQbPAWJbDgL7PVJyAHlCmWskQkJl0qvVI7LYAH7PiSoHrq
	2jB9w7tr9rOsHsXDXTgC+e+kw2/BsDd4FbKZ60gqt0htTBKdpTA/X1s2ikqp7DINfHaVnmALQ3d
	iXacbAEZJKQF3ASvTCKJ/D05KOcctdDphZXpjfFiGG2uxhuUU0xKUJ7rNsQIXGrwnfIsoNBXdgG
	TFPBNSVcoIih79yw/EDrqCdWzWcn/w0spDPwVtdKD8qqk145kmlXbnn/iuXk3/CbYdxjFvEcane
	LI67CVmTHV05WdYBhGwKSAVwk/bwztdMUK+m30VEYOWOewkGzpybPzeDZNLi6AxHXO5MHxJRCrG
	7BeZCdWOt1WfdVXZ1am+RCQ9AYiNH/FLuAW7TmuUcjRjX5ffECcq4kAmvQyMkJM+C+gc3LUWYb/
	xhFWyaEsgxmWMEjyV8Tt4hmg9JcB4Q=
X-Received: by 2002:a17:907:e902:b0:c1f:922d:34c3 with SMTP id a640c23a62f3a-c25570306acmr303394866b.14.1787903088166;
        Fri, 28 Aug 2026 00:44:48 -0700 (PDT)
Received: from buildhost.darklands.se ([2001:9b1:ff:d701:51eb:176f:63d9:53f8])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255f23d434sm49160766b.54.2026.08.28.00.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 00:44:47 -0700 (PDT)
From: Magnus Lindholm <linmag7@gmail.com>
To: sparclinux@vger.kernel.org
Cc: sam@ravnborg.org,
	andreas@gaisler.com,
	arnd@kernel.org,
	davem@davemloft.net,
	glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH v2 00/28] sparc32: sunset sun4m and sun4d
Date: Fri, 28 Aug 2026 09:44:46 +0200
Message-ID: <20260828074446.9768-1-linmag7@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

On Sat, Mar 09, 2024 at 07:15:21PM +0100, Sam Ravnborg wrote:
> This is the second attempt to sunset sun4m and sun4d.
> See [1] for the inital attempt.
>
> The sun4m and sun4d parts of the kernel have seen no real interest
> for several years now. Last time a few people surfaced, but it was
> either due to a personal project or for nostalgic reasons.
> It is time to let go and drop the parts of sparc32 that in reality
> are not in use.

I'd like to revisit this discussion. I recently got SILO and modern
kernels working on legacy sun4m systems. I missed this discussion the
last time around, but I am glad the series has not been merged.

The kernel patches are available here:

https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.com/T/#t

The SILO patches are available here:

https://github.com/linmag7/silo/tree/release

Code that is not tested or maintained will inevitably deteriorate over
time. I hope we can keep sun4m/sun4d support in the mainline kernel. If
the lack of testing and general maintenance was the main reason for
proposing its removal, I would be happy to help with both.

I have plenty of old SPARC32 hardware with various CPU configurations
available for testing, and I am willing to assist with maintaining the
support in any way I can.

Regards,
Magnus
