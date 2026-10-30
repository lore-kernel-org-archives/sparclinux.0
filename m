Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.133.4.66
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793342853;
	b=r9YVlRTygxITs2qOJIOMKb7ocDCh4H5i6hBXWDcWfG4tDJerDj0w3tfrqpiBWTr+Nt2N
	 NTEM76nCvjLTmM8CVjJkzyAZTO/UWuQXR5vka6Gj1niYoQeaYML9aWUU46ax6jBKcZdJ9
	 5/w4n0rHB3KQc6wee6f3tYmDbr4NAHHqP/OAHAFw9/VUnOrChY3Qzkqx1qNM57zymhLic
	 CO7ZnaujBWlX8drJkNyXMSFHWko2O9ugz78WdEAQODz8zAtk0pjj31Gx8s8uwVYXIhh5U
	 wxR3+CUL3aYoo8/tKjsLQC4Wfd6gOwj4V/y8oz9+CdUaDszKiPzv+Db+xZXoqdWi9zQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793342853;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-Original-Sender:
	 X-Originating-IP:X-ZEDAT-Hint;
	bh=CGO33vjjhHPs7FpZgp+z6k/2GQzXxoPaZjErD19+PFo=;
	b=l/Pa+gMFqHms33kc4xOIVLyD+JHtiBpPDN2BCE7yhEUk2+oy6Qv59PBSmimktOijL9EU
	 /wrZ+xcNrD41yIWdWxTuObQ0GomM5AbJF5wp1DKMTzS6PXag1LaqAWOJaLNnQayUg9zo3
	 i3L9XkaOo4VqWuOynczZHiJFbHau9IkV8XMXo9jeuc7LlqXDd4atXvh9829AJ6oAz+pA7
	 JY+B1oBWL5nnlrp0WvwStWP0S4OrJTS7OvxkH0iIk9lOahBDsoylEFz2/w7NpYMDZX3Rh
	 Ez4wOUxLB16ETyG4Y3p7rleZiVYUii0jweEY9gYdCb1imdK5LQ1v6jHpaDptunC54LQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=physik.fu-berlin.de;
	spf=pass smtp.mailfrom=zedat.fu-berlin.de;
	dkim=pass header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b="kj0uS7U/";
	arc=none smtp.remote-ip=130.133.4.66
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE58606A32E;
	Fri, 30 Oct 2026 06:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEE58606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fu-berlin.de header.i=@fu-berlin.de header.a=rsa-sha256 header.s=fub01 header.b=kj0uS7U/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:From:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=CGO33vjjhHPs7FpZgp+z6k/2GQzXxoPaZjErD19+PFo=; t=1793342852;
	x=1793947652; b=kj0uS7U/2fEidI9yXZu0LeL6Vd0FA4PWuRbb6hVbaFmm/Nxsw6CAVOPfhuWPE
	r6lUMTIOMHRXhnidzKlufwpxjfp7RnQCiSza2+YrL54JNPo4EP/oQ9aI6T9saSTVVu6B5Ebmxjrox
	S3CqyIU9FHrxW4p06bjOe6HRC5SOiF5LTP/DerC/qL1mIgN2X+R13xxX+yTuLDGwMXVrzGuvZv8t4
	IyO5m6vod03GwA+lzU9icSAsiJc0cjGumhEjQhG/6n+bFJAPJMDFzrdQUDPQvcQjB4qqQeQAL8Z4Q
	Ha+3TNjyF+PiR4FW9dONBYOP2bVGCNIp1HFYq8u8hTLNlm7pbA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.100)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1xMgOZ-000000034ab-0Yth; Fri, 30 Oct 2026 07:47:23 +0100
Received: from p5b13a90a.dip0.t-ipconnect.de ([91.19.169.10] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.100)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1xMgOY-00000003wUa-3QAW; Fri, 30 Oct 2026 07:47:23 +0100
Message-ID: <a429a68d0675786cd95f9acc0da1c516ff330d98.camel@physik.fu-berlin.de>
Subject: Re: [GIT PULL] sparc updates for v7.4
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, David Miller
 <davem@davemloft.net>, 	sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 30 Oct 2026 07:47:22 +0100
In-Reply-To: <CAHk-=wiXTPC_jJ9o7k2JGVwA=F5_JFt4ikY2J4E69xJqYtAFGg@mail.gmail.com>
References: <5df90753-163f-44d3-ae93-c6be6ca8647c@gaisler.com>
	 <CAHk-=wgrPOQTFxy-mV2EaWLj9RvHY151sQTQ8jc7e0FiorhvDA@mail.gmail.com>
	 <2c9bc34c-f0e0-4b71-a1d8-bc2881d1a7d2@gaisler.com>
	 <9d7432f2a82685fe36f807a38f4ebd0a76f1cabf.camel@physik.fu-berlin.de>
	 <CAHk-=wiXTPC_jJ9o7k2JGVwA=F5_JFt4ikY2J4E69xJqYtAFGg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Linus,

On Thu, 2026-10-29 at 12:49 -1000, Linus Torvalds wrote:
> John, wow I don't want to pull anything from you, since you clearly
> have this completely broken mentality where it's ok to lie about
> rebases to hide the fact that you do it.

I have not said that one should lie about rebases and the commit history
of one's tree. I was merely trying to help Andreas fix his tree so it
can be pulled.

I'm sorry if I left the impression that it's okay to manipulate a git
history that was not my intention. I'm already going through a shitty
situation in my personal life at the moment and I'm not really prepared
to just take another hit like this.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
