Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA71E7C2D;
	Mon,  7 Jul 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903166; cv=none; b=hznCSVq1WTSVgV8lhH2hnZVnDQvEJEhWCoZ5kP86oW68gJexL4QOWzdEFvj+g0JCd86V4PeKVvTKo5wUy3BT3YteTdTbjj0j/Rg3N++clfjNUec6SS1vVIaeG4BODkB0s00d2GN9v7uG4Px2owojDcHjD7/pTUqdMxfJvOtM8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903166; c=relaxed/simple;
	bh=k+Zo9DwDn7cmRtehkkin80GQIRrIRJXwwglai0q/P5U=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ZR7syuh2++KLEbNVCm7BbRkJluHtGO7GuIGN6ytSthd6wu8zEsowuuLqJiZlUtlFSrMtRvuuWFspsvhA5pTf0UNZGPqZo36DR1W6dFl4yob8tMyJwMmLqWEsx+4F9NqeBICQkKap2KK0axETxkdN7iSq0vbftL9725tJD1V5LS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=hmtt/vub; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PD747uzS; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="hmtt/vub";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PD747uzS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 26063EC0BB6;
	Mon,  7 Jul 2025 11:46:01 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Mon, 07 Jul 2025 11:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1751903161;
	 x=1751989561; bh=+Un+RGUiJ149lGAuhrtubfEw3DZX4pSjaf8URdRFHiM=; b=
	hmtt/vubB5feY0mZ5Ji1CfCDASCA/AcD2pTVZANulMdR1a7f/3NzHVOWySpM0GMP
	/W+DLWf/Xe0wfUKQJggXpgC8Wg9MFal1i/Xwwa/VIoLfKp/E6Nusr1vJUCEtTF2o
	QJhLvjEJODqLX7g9zFSIOCigk9v8C/EWxw5OTxMubXJBQO53KWBbo33bCqiBXah9
	8gTKRQlfag/8wUNKKJ5e3lTExLYaFybUXmVevFznCzUzedp4oLuTPQtmOp8rA3uk
	+AvU7+/O9gNyxGTSMkBrzz9RQU3GP926v3kNsSu1//ueOia7Ue/aOUVckGfm31Kb
	/RSVUW9IewSPJzZ3zNWV3A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751903161; x=
	1751989561; bh=+Un+RGUiJ149lGAuhrtubfEw3DZX4pSjaf8URdRFHiM=; b=P
	D747uzS2acBPqps9sDDtyqo8jJIOC4VvnHp5Eid1MSs/Y6aVstHN8uIm5zfWBs3f
	v6lH5My2cw8XTiV6lJPJ5Qy+PmN4alxlYNe+NXc9+jY33t1hVm+llD9DzzqwwP6c
	iyoreuxCYKpdUzxo/NuBb8pQ8oblAkePmpvEQVL1AH63NjSEGcYaSbyXWyTNE5OB
	DO9ojX5QFqZNeyDtUPlBrNO28up4LlTjb5WjJLPjWVtClEfpvwyKRkl7eaAJd40/
	IGp9bukl+FwWY5a9H0WjDVPvgQGxjcC9e2sd5gXgH8ib6AeSxGVnhEEfgyY9FP1i
	Xn/G3tWdwJKmEE1NBHm9Q==
X-ME-Sender: <xms:uOtraK-IytIFgw8yTrzqMPktMw5129gToBQyCQtuS2eK0zVQWpHwbw>
    <xme:uOtraKuIU8JFishj823QiD_1_txkc_wU0h7kyBh2IqfLLHB9Izg_FwWC6uHDB9cvc
    7UPfS0A52B4WDoSvjc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefvddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtthgvrh
    hnpeefhfehteffuddvgfeigefhjeetvdekteekjeefkeekleffjeetvedvgefhhfeihfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghp
    thhtohepudekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtrghtrghlihhnrd
    hmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepvhhinhgtvghniihordhfrhgr
    shgtihhnohesrghrmhdrtghomhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtoheprghnughrvggrshesghgrihhslhgvrhdrtghomhdprhgt
    phhtthhopegvsghighhgvghrshesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhsth
    hulhhtiiesghhoohhglhgvrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehfrhgvuggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheplhhuthhosehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:uOtraOetqdjQNoh3fHCBDTFWqAcLBK6Pyto43ykqD5j9MrQkxqKm6w>
    <xmx:uOtraJksi7dWZHIKcKWpQEUrH7KkNBNv67Y2hBYBiUXSor6CG66HuQ>
    <xmx:uOtraIwyFpe8N7kSdAGClIN7B-7U_ISVXPzV1z0zHne-2E7_oLTzxw>
    <xmx:uOtraEME5Eq_lRcY4f6oa75Pu2gJRi9knV-dzcstHJmA4wK4sqSYzg>
    <xmx:uetraIQCTD8jn7c_T2CEfjTLhvD-qs0pIwwbP4D7uyEjq4y5YWjSd293>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 6559D700065; Mon,  7 Jul 2025 11:46:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T47b27644593db411
Date: Mon, 07 Jul 2025 17:45:35 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Arnd Bergmann" <arnd@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: "Andy Lutomirski" <luto@kernel.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>, shuah <shuah@kernel.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Frederic Weisbecker" <frederic@kernel.org>,
 "John Stultz" <jstultz@google.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 "Eric Biggers" <ebiggers@google.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <5c479b4d-65f1-466e-a79e-43f6dfc9345c@app.fastmail.com>
In-Reply-To: 
 <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
References: <20250707144726.4008707-1-arnd@kernel.org>
 <a2cfee1a725f24f90937f070eacdedd2716ef307.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 1/2] vdso: sparc: stub out custom vdso implementation
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, Jul 7, 2025, at 17:22, John Paul Adrian Glaubitz wrote:
> Hello Arnd,
>
> On Mon, 2025-07-07 at 16:46 +0200, Arnd Bergmann wrote:
>> Rip out the whole thing and replace it with a minimal stub as we do
>> on parisc and uml. This introduces a small performance regression when
>> using a libc that is aware of the vdso (glibc-2.29 or higher).
>
> Can this performance hit quantified in any way?

It's trivial to test calling glibc clock_gettime() in a loop
on a specific piece of hardware, the difference should largely
depend on how long the timer hardware access takes compared
to the syscall overhead.

On machines that have neither TICK nor STICK clocksource, the
simpler version should even be minimally faster, on those that
have one of the two, there is an added cost for entering the
syscall on every clock_gettime() as we do on architectures without
vdso.

> And is there previous serious where this change was made for other archs?

See 
https://lore.kernel.org/lkml/2078551b-c0b0-4201-b8d7-1faafa3647e6@app.fastmail.com/#t
for the thread that led to this one.

There is also commit 5f55e098b8d0 ("parisc: Add 64-bit gettimeofday()
and clock_gettime() vDSO functions") that adds similar stubs on
parisc.

      Arnd
