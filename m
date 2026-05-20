Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13863A0E8B
	for <sparclinux@vger.kernel.org>; Wed, 20 May 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779284470; cv=none; b=QmQWralRl0dujIwRVR6NpksXMibEvZ48WrRH2ezx0BO/U9OlD3tYWGuXl9tuBVZjyLgQ1Ld+M8CVQ+lZifCX/7W5b+nvQLOGfKdsri+L4loX4UNxxOxme3k8VfG56ZehGS5t4CInCIb8gYck+tlHfAol9rpCIUdIeV4lD/p7ecQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779284470; c=relaxed/simple;
	bh=9zR/Hf6z7N1IsGt+VW/yYO2sLyoz8qP7waAI+MYVktE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JhDEwnA2OEki2vw39sUsxlBWq1mxD8j/JWcyhj2kPkl/Sg9e1JsunDdaMwDcQgavOphQHb1ZRsUOpMbdUTFb0gjengM3b3BI8BY9YglgVikyt6f801gyphbsck+LLRCB59ZeWL+AEhZM3eY3OXBPolJxb/XtsMP+BMeLk4TCVvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ihVmC5H4; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ihVmC5H4"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4890d945eb4so31520315e9.0
        for <sparclinux@vger.kernel.org>; Wed, 20 May 2026 06:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779284466; x=1779889266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vfk/0mVcnY/X27KP5hrre9gbSIDn/b0aV1xxYD9Hst4=;
        b=ihVmC5H44a9I0WZVk8oSLXrGYbfYzmO8RE7+AU343pCAIisxwblbSRy7TAi9cCBuOS
         AY3O9QsGcJNXWy6sLfWO8w03EU6d6Vg3NusJv0eSz6f/+W049VQ4fQbrqR7MFEpup4RI
         /EsnCy+DQPZ73LSzNLGrVtTZYkxf0QTizM9PLltHgVLWERguQD7pwnul4QksBla4YJBp
         bYOtEw0ZJs5gyjJxM/wmqLI9iwZoKHfxCfqf0kWWGL9BHumbiWBqyixmiQcaSdaKJWvb
         cTkHBo7NSC2yCoaTTziHblJ1g+p35yZBiq353LQ2RHW7Ayjzh1RJewmGqyfwYc6tbLZJ
         ++vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779284466; x=1779889266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vfk/0mVcnY/X27KP5hrre9gbSIDn/b0aV1xxYD9Hst4=;
        b=mjGwZBlPa4aG+vsmkAFmbGYzxYNIPkbpCG/JxBMJahiBSjB/nfzWuQNhO6CFrH/573
         lrVs48xUlIg1/dFsEs57ODt8+kNG8G54sbMwelX9f9LkBhIW84nWDNHgdRP9uzPNJiXq
         SW5Whq020wCuMNTsSN9XHNQe9RhlWDA/xSuZ4iRACnJJS5nZlxKxJud5F0NfpKxBn/hN
         msYZhZaHfryztDtQ6JnfgLhlliGin/4xQYuHQILVW5FxtQmCpXbELDBcW/JtcUxYMkYk
         PtoDNsHi0Q+oG1nwDAKEqytXgqYXqPg0j9efMqX+0Pe0O1lHrKZ2KEoG9GUTCRp0a2iJ
         RPsQ==
X-Forwarded-Encrypted: i=1; AFNElJ9D2eLXxu1/Lynfbd1KBrPwgaj5NlP6QJw43Gc4Niapk1gVR0yoBxrWFDZhB585fJoErSy7vctxs9PV@vger.kernel.org
X-Gm-Message-State: AOJu0YwLvvgFycn/OhkLB56Sh9uPnRgVO/AIT6c/HDcTtZJdNYNAxTdu
	uDYe49m1kh7WHgB2rg89HgKZjtZIMPejD5CfrE4kRZ8DaMd+fwtKNRHK
X-Gm-Gg: Acq92OGS5odU/0nTGbx9VM3SHQNLwnOfRASwce8tQzfyDjS5HtDr6lsk/Lz1TWGffeP
	fCCNkTE8Qk8Kvr3qr6nccp9X2KASdkhdrof/RkTmYQ6yWxUQQWKGkreS1W9t96AQYESdEhmFMYV
	ABSqvYKzb/WxPEsAC5Zg2eEy7XfW4xlxC9cy6PY5SWGXXRdGePdXl7dD06U1ZFUejJGXLL6+PeS
	92xqt4BOFeIBgX7H4iQg5Fk6XeN/RdYOqMjRCzcP6YUbIWplC6UsmBhPlhz3x1C89S2X3up6qg/
	d8QkkADbDa/3iUn3y3+yLeTlV0QcPPuA0crQsM3rSN+Bizfpg9nd1h0m7G2litnnxb4QTnKuE77
	ni6/oCJhfdryHFfCospkOv/wgR3hyz6yH0ZlKG6hzf1B9M7WQyB82IFrLyT82tiGMhEHjIHufcV
	TR1DuwnhgOP5W/oUzIE7Ht5pAUAE/v+ff73QAK4jmmNrE3HbId0vKZsDRoDECfvnUq
X-Received: by 2002:a05:600c:1d09:b0:48d:50a:6ef4 with SMTP id 5b1f17b1804b1-48fe537fb44mr313902805e9.11.1779284466032;
        Wed, 20 May 2026 06:41:06 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe53ab6aasm429607155e9.2.2026.05.20.06.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 06:41:05 -0700 (PDT)
Date: Wed, 20 May 2026 14:41:04 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Tony Rodriguez <unixpro1970@gmail.com>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, andreas@gaisler.com, thuth@redhat.com,
 regressions@lists.linux.dev, glaubitz@physik.fu-berlin.de
Subject: Re: [PATCH 0/1] sparc64: unify thread stack sizing and add explicit
 32KB stack
Message-ID: <20260520144104.618c75ca@pumpkin>
In-Reply-To: <05e0e7a5-107b-410b-853b-883810b1be3e@gmail.com>
References: <20260519075809.8993-1-unixpro1970@gmail.com>
	<20260519110223.5aeb88e3@pumpkin>
	<05e0e7a5-107b-410b-853b-883810b1be3e@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 19 May 2026 16:57:04 -0700
Tony Rodriguez <unixpro1970@gmail.com> wrote:

> On 5/19/26 3:02 AM, David Laight wrote:
> > On Tue, 19 May 2026 00:57:54 -0700
> > Tony Rodriguez <unixpro1970@gmail.com> wrote:
> > =20
> >> This patch fixes a reproducible stack exhaustion issue on SPARC64
> >> that occurs during USB hub enumeration. This regression may have
> >> started sometime after kernel v6.12. With the default 16KB kernel
> >> stack, the following panic is triggered early in boot:
> >>
> >>      [   25.528399] Call Trace:
> >>      [   25.528403] [<0000000000433cd4>] dump_stack+0x8/0x18
> >>      [   25.528419] [<00000000004297ac>] vpanic+0xdc/0x318
> >>      [   25.528429] [<0000000000429a0c>] panic+0x24/0x30
> >>      [   25.528436] [<0000000000be2280>] __schedule+0xa8/0x7bc
> >>      [   25.528445] [<0000000000be2b60>] schedule+0x24/0x4c
> >>      [   25.528452] [<0000000000be6970>] schedule_timeout+0xc8/0xe4
> >>      [   25.528459] [<0000000000be3318>] __wait_for_common+0x78/0xf0
> >>      [   25.528466] [<0000000000be3550>] wait_for_completion_timeout+0=
x1c/0x2c
> >>      [   25.528473] [<000000001005e2f4>] usb_start_wait_urb+0x68/0x128=
 [usbcore]
> >>      [   25.528502] [<000000001005e468>] usb_control_msg+0xb4/0xf8 [us=
bcore]
> >>      [   25.528518] [<0000000010051180>] set_port_feature+0x44/0x54 [u=
sbcore]
> >>      [   25.528530] [<00000000100530f0>] hub_power_on+0xc8/0xe8 [usbco=
re]
> >>      [   25.528543] [<0000000010054fd8>] hub_activate+0x12c/0x644 [usb=
core]
> >>      [   25.528557] [<0000000010059438>] hub_probe+0xdd4/0xeb0 [usbcor=
e]
> >>      [   25.528570] [<0000000010062360>] usb_probe_interface+0x234/0x2=
6c [usbcore]
> >>      [   25.528585] [<0000000000a10a40>] really_probe+0x1ac/0x3b0
> >>
> >> This is caused by large SPARC64 trapframes, register-window spills,
> >> and deep call paths in usbcore. A 16KB stack is insufficient for
> >> this workload. =20
> > Increasing the stack size for all threads seems overkill.
> > That stack doesn't even look deep.
> > I suspect there are large on-stack buffers in there.
> >
> > Unfortunately the traceback doesn't print the stack pointers making
> > debugging hard.
> >
> > -- David =20
>=20
> Hi David. Any specific grub command line keywords and values, and=20
> functions you recommend for debugging this?=C2=A0 I would be happy to sha=
re=20
> Trace Calls, etc. so it is easier to reconfirm and zero in on the issue.=
=20

Without the stack offsets from the dump, look at the stack frame sizes
for the functions in that traceback.
I suspect there are too many that get near the compile-time threshold.

-- David

> -- Tony
>=20
> >> The new logic is:
> >>
> >>      SPARC64:
> >>          THREAD_SIZE =3D 4 * PAGE_SIZE (32KB)
> >>          THREAD_SHIFT =3D PAGE_SHIFT + 2
> >>          THREAD_SIZE_ORDER =3D 2
> >>
> >>      Non=E2=80=91SPARC64 with PAGE_SHIFT =3D=3D 13:
> >>          Retains the existing 16KB stack behavior
> >>
> >>      Fallback:
> >>          Retains the existing 8KB stack behavior
> >>
> >> Signed-off-by: Tony Rodriguez <unixpro1970@gmail.com>
> >>
> >>
> >> Tony Rodriguez (1):
> >>    sparc64: unify thread stack sizing and add explicit 32KB stack
> >>
> >>   arch/sparc/include/asm/thread_info_64.h | 28 ++++++++++++-----------=
--
> >>   1 file changed, 14 insertions(+), 14 deletions(-)
> >>
> >> --
> >> 2.53.0
> >>
> >> =20
>=20

