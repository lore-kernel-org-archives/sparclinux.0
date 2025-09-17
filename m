Received: from libero.it (smtp-31-wd.italiaonline.it [213.209.13.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC0430648A
	for <sparclinux@vger.kernel.org>; Wed, 17 Sep 2025 09:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.13.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758100097; cv=none; b=RD4eTQD9mZGRy/H8INUr1XbvCOePTn+g+YLhoylxn4KeIAkxfc+FccvKGKwPkdTTNenfB98THa2i3lwCZ4gYv3hITKttN+U5bdvoLsVfcsvXm48DHwcHzP/sHpKY9XoQfrWAF2bupKb/v89Gv/4icJDQSQ2LSpLiKPBdHO5ptb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758100097; c=relaxed/simple;
	bh=hKsZAnlwLXcNJbfSz4DNw5s/WxjNZWVtryh36+RZufI=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YosBWlrvrrVwJ/ogEK80eMoOMUraW39qDCtDIyaQbu+kwfvtXoqfB2arK7EdTP9V8hV2j9309FWcXOwqpXl6Zmk+3tZOp6CEHO2ozeLZcpNf08PrpAOuCPCCQ/ZNsxp3H6NEWMpOQYXejnP3bOT4QVw30J1uzdNyGMyQti6hCG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=BeWFzeN5; arc=none smtp.client-ip=213.209.13.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="BeWFzeN5"
Received: from [192.168.1.36] ([151.65.2.228])
	by smtp-31.iol.local with ESMTPA
	id yo6ZuY9Qp90dByo6ZubuM1; Wed, 17 Sep 2025 11:05:36 +0200
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1758099936; bh=xn2LP2IBbqANW50oSBC9DQCp7oT+fiObMHeTV99eHD0=;
	h=From;
	b=BeWFzeN5FRjwxuqwWzH4OOR5hRAl4zlWKvkw6ZyiiqvUxcCmkr+pcbSBFLDjdooH8
	 ska0pkRIZ4dSGfzMz/DqTX+QuGSXHDu1zhodbug0CXyO4+zzlTIIC7u5IXr5tWoaNM
	 4Rw9F+/+ORYl+CbP+ei91+Ob/u6zRHebvsWapmkRIGyckcEzrAM6oKJao0ExhWn13M
	 ecJLurHZ3yItUK8jt2MUiCWDih80hI8urfu54qvMoW2uumwRKypQYECr+UkhT6DDnP
	 SKuDbCv7qlxGusnN+PyBOOX/FLZVFawv2h4l111rdKZmPhigLgL+NYBersdZAgaOYl
	 DUxLFLWacnBOQ==
X-CNFS-Analysis: v=2.4 cv=bNoWIO+Z c=1 sm=1 tr=0 ts=68ca79e0 cx=a_exe
 a=fUUb/luldTa8vXwyIFcL2Q==:117 a=fUUb/luldTa8vXwyIFcL2Q==:17
 a=IkcTkHD0fZMA:10 a=ihnBSnL_DBxndnvbySEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
Subject: Re: New test kernel - second attempt
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "<debian-sparc@lists.debian.org>" <debian-sparc@lists.debian.org>
Cc: sparclinux <sparclinux@vger.kernel.org>
References: <9b8530550078b5e89b19e987981d25fee8e18500.camel@physik.fu-berlin.de>
 <7515a193-5ae2-69d6-9c6e-c3b6c7459f50@libero.it>
 <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
From: Riccardo Mottola <riccardo.mottola@libero.it>
Message-ID: <cc22fff0-e704-6a70-6738-da349d3a7ac9@libero.it>
Date: Wed, 17 Sep 2025 11:09:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:128.0) Gecko/20100101
 Firefox/128.0 SeaMonkey/2.53.21
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <73e81a8280b345ee09df0dfa9f0e21148144722f.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCGvcNSgjKUaEOqc0u31HHRRqfwAiIVTW0MwVNmAweONizPEm7fr7W103nlALjRDClIjMROg6lw8f/WXpg+ZCU9TFUPBQxM9AIX6ExG6wMt27GS7yy3u
 gViY9ZP2JhAktnQREYcZIv9r83UjGDZHiSj3Ue1Bq9UCl5Wvh0CYiuc7X9Md6IYZYCpNfLvxVTtgsO2Gr41AcNVZipfgPBi7Qn6VJ1SL6kvEncAOSiU7SGBF
 BcXi2r+2FUCcP8dLIr6bT41DALKA1SFw/muLuYZbTc4Psw5k7GgLn0QUtyh6nK3B

Hi Adrian,

John Paul Adrian Glaubitz wrote:
> Keep in mind you may have to keep the machine off for a longer time or reset
> the NV-RAM. We've got multiple reports now of machines that became stable
> after that.

I can retry. But with a Fire T1000 or T2000 it is not as easy as with my 
other systems: the system LOM makes in any case a poweron-selftest where 
it power ups the machine and powers it down again before one can start 
it again.  It makes physical testing a little more complicated.

Furthermore (but it might be my fault) I cannot type anything on the 
console. I use the same LOM serial cable and same setup on my T1 and 
there I can "type" in the LOM commands for power-on, reboot... on the 
T1000 not: I can read, but not type. I everytime need to physically 
press the button on the system, wait it to cycle. Once it comes up, I 
can use GRUB to select the kernel and it responds to console input as 
well as if a successful boot comes, the login also works. This proves 
that the cable works (well, works on the T1 too) and also that the setup 
seems fine.

Riccardo
