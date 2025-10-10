Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7C8229B2A
	for <sparclinux@vger.kernel.org>; Fri, 10 Oct 2025 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760064525; cv=none; b=juBWbJsZvguQIC2gipYjuo33iwqhLvqsITCoXME1VhyDERMk8GqVN3bVR8STEgyWa0PrQEyPrMfH/NftKZ80Uj5SZz0M5638i8++Q/NuQ65RYklfmklmbnciq1mdFI8Dxw+6tEGVni8hrAnQjLuQTHssyRocW3JyPEBgH7IK9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760064525; c=relaxed/simple;
	bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uri0p/F5/4I+m6UPaPd7reEs8ZZGp4NfX/uLZnZvIpyjp1Evr4AJBpKuIYJ8/WVZGNCtKp6NgoG6Vzv9npTdy71vLN4YVHp7LyYGyxKwqEMcf3N1gYbRNfk38VGkhjBuzdjbF+RDxMXy3N2XPW2xGO1yvo2NWHWThSQaBa5IDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=elQ/QoLE; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="elQ/QoLE"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-74435335177so41239517b3.0
        for <sparclinux@vger.kernel.org>; Thu, 09 Oct 2025 19:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760064523; x=1760669323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=elQ/QoLEl07oguGQwVeaLuPvx9pg+ZF3HObzItQAr16R2PwjJJ/BJhHlsBagHWRo1E
         q4f4I5TainPicRHfP4mxi/QA8fweTGrjQlrXERSkdlr6KgU4ZilfiRp9i5MkNzxdmJFE
         GqtJBFbDrYJM4r8+ph0NGbgZ2YQn4dQX2PL+zpJpSkH6dn2eia2X9CYfK8q38r3RGNos
         FYWwKOjsxbNPoX+OU5D0/LZM5lIAyQ56jv8iMtnZPsc8rn7rN4UBS2EkrASRagSQ6iHh
         M0HiA7o+kBUytakpqhUfCayQ9hhTHxglANqJie8IdxhcFjjr6XDM3XOMyO0pRXWHPZL7
         uJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760064523; x=1760669323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SUvjTYrAKggs3w1tKlxCJydt04WX0hyij5ZVnNtO2rY=;
        b=wsqFGqpB28Hcq9m/D8hV1/Xa9Z0Ymwy7lYqVzff4/2Or/ThwbPN6IrOe7HdykMgQA8
         JuxWRUOoB3kluQq8O5MilHUPlrHgLPf66IcKYvOiz4guawI5yljrhKDSznf/knPiCu+l
         y5MAKGcY1MY8g/87RN3MFzvkBlJfckTDzo0etzHcDf+jQoUNdhP/ygsSkbIBmb2hjKPp
         T8x0kUBGU2fwBnJ+B4kAYd14Dccwq/ZmhY3+xnvoDYGdvuyw75TJSlj/T3Gta/BIR9sk
         UYkkmRB67ozcdrHmsz7QqurPE9pWL9keLmg1ME8npUsr9et7rQ7k5X3woBgnZzU4L5a2
         vHZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0kGVoJZxlNgITWfoXkKoYTchuIg2aEps9dM8lApJ7bx5fsXbwjc0OgGn7j2SRxhc2HX8pieyOxaAd@vger.kernel.org
X-Gm-Message-State: AOJu0YxoneSw7wpm+UmY2E5fuZ38IZClQ9gGLACc0kx/kZnTtI9u94AN
	xrypwT62+7NJdXbL4tCVt+vGu2PTK+nGS+LLi0NsuJAIvCNJ0fcoRmGELOzca6AWNqYxVDxG84i
	93va5swxgb+FGLf5Im+KxyYrZ30W/xaY=
X-Gm-Gg: ASbGnct7hP6blc0tkEqtEHW771ZUfFMQoyyuQHnHgEnIuVc22awY6wg5+vPMXWaygPL
	w4NffdzzTUio2Wr9yCgl4MkqmrBOdOf+W+jTX839lDJQUCdXJ0CT8CsevQBUvRTXGJd3+LsawyZ
	5bVFOeg6CrMERHSDVt5tdA5q8SKxtd4AiQaOcmdol+nITU3PloRsCzMbAgmzpGxofFquGQqTkXw
	p3RPCQ6EMG9Pd2ydl58yactzPx5FJgXH4lbB3YxHg==
X-Google-Smtp-Source: AGHT+IE/ruZR0Nl+gZjd7KSfaZ+4Yt5azf8Eoz6teA2EZ5XcCIQ6BBXF8AxOCZshaSTrV+l7WDzDAJYCcqNIJ+IMELc=
X-Received: by 2002:a53:cd0e:0:b0:635:4ed0:571e with SMTP id
 956f58d0204a3-63ccc4fd4b5mr7697871d50.22.1760064522649; Thu, 09 Oct 2025
 19:48:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250913003842.41944-1-safinaskar@gmail.com> <20250913003842.41944-22-safinaskar@gmail.com>
 <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
In-Reply-To: <a079375f-38c2-4f38-b2be-57737084fde8@kernel.org>
From: Askar Safin <safinaskar@gmail.com>
Date: Fri, 10 Oct 2025 05:48:06 +0300
X-Gm-Features: AS18NWC-iakvkxLfUlO1LRxakg0fg4KV7Trw_hsIF2wxGpnmpWZvHTCQ7Z3GaoE
Message-ID: <CAPnZJGDK08eDWaMTmvVQwkAAThUvgB0XgAapqqV4_ZmWeay-iw@mail.gmail.com>
Subject: Re: [PATCH RESEND 21/62] init: remove all mentions of root=/dev/ram*
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>, 
	Jens Axboe <axboe@kernel.dk>, Andy Shevchenko <andy.shevchenko@gmail.com>, 
	Aleksa Sarai <cyphar@cyphar.com>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Julian Stecklina <julian.stecklina@cyberus-technology.de>, 
	Gao Xiang <hsiangkao@linux.alibaba.com>, Art Nikpal <email2tema@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Eric Curtin <ecurtin@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Rob Landley <rob@landley.net>, 
	Lennart Poettering <mzxreary@0pointer.de>, linux-arch@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org, 
	Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org, initramfs@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-ext4@vger.kernel.org, 
	"Theodore Y . Ts'o" <tytso@mit.edu>, linux-acpi@vger.kernel.org, Michal Simek <monstr@monstr.eu>, 
	devicetree@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <kees@kernel.org>, 
	Thorsten Blum <thorsten.blum@linux.dev>, Heiko Carstens <hca@linux.ibm.com>, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 1:06=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
> Please wrap commit message according to Linux coding style / submission
I will do this for v2

> To me your patchset is way too big bomb, too difficult to review. You
v2 will be small.

--
Askar Safin
