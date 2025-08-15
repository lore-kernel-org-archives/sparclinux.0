Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1DA275846;
	Fri, 15 Aug 2025 20:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755288590; cv=none; b=MeQ+eR9PxBemQ34R+FPwy81xwCxaefkL0/+RW+dOxXx6sgq0qvnsyBF3U6FJMS6xP1njVi8l4mt7aBojQMlK8guD4e7G+vI60MTRgEIF3eSnZWPgLHN2EulLiLB9vZ2Q7wYR6Xb9364bXktcp/EEPRrWmAY/C35iFU7n0BTUVhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755288590; c=relaxed/simple;
	bh=tdtaQ8Py9WTzcEhcSKqfH4yu0RxqqKT8KKMjNHpYPbc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=d9jiEQWKVkXBkVFjjoEUKbG0WYi8c2iOukD6Ik8UJ0xIIWug+zha2H291haBaORJ3R47+0mHVbeG6vIt8xmZYDfJFw3l0qhXpV+H98/YXJ51s70OgDSWRMRWqlq75gWIuIPxSc+ZQCkCKB6mmUIdXJCwJntWBkII1kvPFxoKmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FQTFZPQ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XVcwB7PO; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FQTFZPQ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XVcwB7PO"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id E395D1D00166;
	Fri, 15 Aug 2025 16:09:44 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Fri, 15 Aug 2025 16:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1755288584;
	 x=1755374984; bh=XwJsgYArgsW+/UjvvRTZNyA2SnJk7nKK6q0JSlZ2Naw=; b=
	FQTFZPQ3Gsn8Wwajqeew8qnRDNKv54BqBt+VCybrRbfvuYrcXGeseNXeC59WYaK+
	VzhGkXeKNlIhpiyOb2MtRoaJ7UZ0teA8rrtR4cstq6wxJEQRn2bb/rlO8xX+yKWf
	GwC1r2FdsqtWV9v51DFH4VtuMDBTwNa7WbWrvzon8PifwH1sOBcGZvJLO5O6o0Yc
	M/S0+I7Jb2BWS9XiTf8U4KR5guL+ygKR1W4115bgXm53fgw00Wdea6DAMkD6LZw7
	NoVc7OJutsxroSnggrRr4BZE+svcZzUZXrnXPvKIDZUiOYUCd00LA/Rghz+4ZhsP
	VMkQ3jAHbIOEwuoehLrXDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1755288584; x=
	1755374984; bh=XwJsgYArgsW+/UjvvRTZNyA2SnJk7nKK6q0JSlZ2Naw=; b=X
	VcwB7PO9Q/I+u2wCZLHWBJHmVNklETts0FwQgvx+Xb/BSn0Io97KSASYbtfCcgWZ
	ULuMVpNCgQftU19z+vE0BFXEQ+U99Zdx5vMKHtlTCqXABEJmjrViSj/9RZlPHLQZ
	3VxZ05X9RL6E8wvYQVUmkuU1MvFxrtu+Zj0ov6JJe+aS4yq5vXbnhWy2Pvvhk8rB
	DiXVQ4OEDB4wFAXBvqDFDxgfRWseyZYxvN0eGn/5fuw/YRKVtOjGizUCYBQl5mJD
	WnSn+tKzNKBLg1Vmp5vn7M0ZU+AGAX9YSGojv8wxJK59UzlaI5oN8CU0B60VoMBA
	Ejm5hbf+clih+0O3gJMOg==
X-ME-Sender: <xms:B5SfaM0yNs48FTAIihBivUH-TDvatxqfTliXDs4T8JV9fygMGfx6GQ>
    <xme:B5SfaHHrqWGuWk3KtJO11oS681iI8yQtSJM_MrxqnX3UJkhhFNILoIvRqmO6A0Lj4
    p2-5WP3BDrH6v01rdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeegkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtqhertdertdejnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepvdfhvdekueduveffffetgfdvveefvdelhedvvdegjedvfeehtdeggeevheefleej
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnh
    gusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudefpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtohhmpd
    hrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegr
    nhgurhgvrghssehgrghishhlvghrrdgtohhmpdhrtghpthhtohepjhhsthhulhhtiiesgh
    hoohhglhgvrdgtohhmpdhrtghpthhtoheplhhuthhosehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehssghohigusehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtghhlgieslh
    hinhhuthhrohhnihigrdguvgdprhgtphhtthhopehthhhomhgrshdrfigvihhsshhstghh
    uhhhsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtohepnhgrghgrrhgrthhhnhgrmh
    drmhhuthhhuhhsrghmhiesohhrrggtlhgvrdgtohhm
X-ME-Proxy: <xmx:B5SfaHdbNgsl2OAq_XIdHX4ZKLfIFAA-sKA5sA7FrVnEJwkMklPEQA>
    <xmx:B5SfaEcpfeeXANTs9OdFAozNH66eiy0yq7QaRBnisDeJIThWU-GLPg>
    <xmx:B5SfaLakVNOBW-oXRBxvP_8txI1n9djNAkDKMIjCbfipCHqoqLkmUg>
    <xmx:B5SfaI4tONJRCriLm0doVc2q6OJiVCxTWGH2xe-zIRVvUVzElBxpdw>
    <xmx:CJSfaKFJyHdRhpf9orOYloDrvWGtDqgF_hlrPA22BqOr7wqGdSjqJQkK>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id CC87C700065; Fri, 15 Aug 2025 16:09:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ABINBsmLUku7
Date: Fri, 15 Aug 2025 22:09:23 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Nagarathnam Muthusamy" <nagarathnam.muthusamy@oracle.com>,
 "Nick Alcock" <nick.alcock@oracle.com>, "John Stultz" <jstultz@google.com>,
 "Stephen Boyd" <sboyd@kernel.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Message-Id: <5309ef99-9ae7-4525-8d58-f954c13797bc@app.fastmail.com>
In-Reply-To: 
 <20250815142418-d28c6551-bec1-4a65-9c52-f1afd7b630ed@linutronix.de>
References: <20250815-vdso-sparc64-generic-2-v2-0-b5ff80672347@linutronix.de>
 <20250815-vdso-sparc64-generic-2-v2-12-b5ff80672347@linutronix.de>
 <bf9ec82b-af1b-4684-ada5-8529b7ceb06a@app.fastmail.com>
 <20250815142418-d28c6551-bec1-4a65-9c52-f1afd7b630ed@linutronix.de>
Subject: Re: [PATCH v2 12/13] sparc64: vdso: Implement clock_getres()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 15, 2025, at 14:34, Thomas Wei=C3=9Fschuh wrote:
> On Fri, Aug 15, 2025 at 02:13:46PM +0200, Arnd Bergmann wrote:
>> On Fri, Aug 15, 2025, at 12:41, Thomas Wei=C3=9Fschuh wrote:
>> >=20
>>=20
>> Something doesn't quite line up here: I think the check for
>> CONFIG_SPARC64 needs to be for "#ifndef BUILD_VDSO32", since
>> sparc32 kernels don't have a vdso at all yet.
>
> arch/sparc/vdso/vdso32/vclock_gettime.c translates BUILD_VDSO32 into m=
ore
> "standard" defines, CONFIG_SPARC64 in this case. I have a follow-up se=
ries
> to get rid of this pattern in all architectures.

Ok

>> On sparc64 kernels, I think you only need the
>> clock_getres_fallback() for 64-bit userspace, while
>> the compat path probably doesn't care about getres, neither
>> the time32 nor time64 variant.
>
> Why?

The clock_getres() vdso call is questionable even on 64-bit
systems, though we appear to have ended up with one on all
the major ones. Realistically if an application needs the
resolution often enough to want a fast way to get it, it can
just store it in a variable.

On 32-bit, we decided against adding a clock_getres_time64()
syscall when we added clock_gettime64() because of this.

For time64 userspace, this means that glibc always calls
the system call instead of the vdso, and old time32
userspace wouldn't use the clock_getres() vdso because
there was no vdso implementation when it was compiled.

     Arnd
