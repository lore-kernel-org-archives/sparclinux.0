Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793642818;
	b=z4vbXFbyC3yVClX1jG15/fkYvYf9pmr0RQ2+gBVnEqB+RnLHeytm+m9OpN/A13Pgk8uu
	 77tCYR4otYoO7GhtzeLyGxF0ZusUxadE0f3sjKqkP8YKDhrUSb6X/kJeoyAO0XrqlO+Aw
	 WB2UvQbrf5awNQd+geee9tr8XCtJEDV53X39cdRLVbncZVoea73Ll8khn4ia0/q1gKzQ3
	 dVtNLgn3GNaIMmvtTqCuvIJx966gRGZhHzBgdJLTVuZb2FfovoKvTGSZHneGT3frmwDpL
	 vVOvLD2PcJOi2tA4EkAsPcGBgwCv0Kl3Bt8u3R5MhLovCj7HZ6dMICDtkNShMhPNc8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793642818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
	b=BmKqh4wU8cchX00+J6n1X1ykPio/Q4ccX2EBld0gzkwZqDKwOnU1/RDWbVVYfdGk2kgk
	 wZJpEusu9fpjq8kvKHPGyjGB50SKHZm4OSdBzJKU/j8KPVTBYU+r17o7kEftWta5r3I00
	 oHaSH1ds94Ibka9YtmT3ndRH5i4Xooz/zSS9kJjT0IGZyqzTf1hsDx3NKnqbirwDlMlOC
	 0yuQW1KDb651FtRVkqMEvHZ8CK5nfAzV9s7yaWKQnQvSbgmOSWCVvIci2qKMd3nYw+KZX
	 SCxWEPpPsQdxr05fFaFUZcxhADBK0MHV5TzmTVTtNkpOy2vHnEsr22WUCEtcNIAxJrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FsvSKGzj;
	arc=none smtp.remote-ip=209.85.208.176
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF23F606A33A
	for <sparclinux@vger.kernel.org>; Mon,  2 Nov 2026 18:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF23F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FsvSKGzj
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3ac65e845a8so38034601fa.1
        for <sparclinux@vger.kernel.org>; Mon, 02 Nov 2026 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793642816; x=1794247616; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=FsvSKGzjL3Nje0n2wMg0TJQ6PbtkBf3OPdCakYWiMB9d8QdcoZ4FZurw5Xrd6ZwFVA
         wrfMJSP0uGGeBVXHJO+MQYw/yyDj3q5vdWh4Q7eAFY2Gj6S9ZU3Tfjnl0J6wOOR92HFZ
         z3t+NHmRmgQWeIBgbTdxPhKBLbJJIvjICFmyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793642816; x=1794247616;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/vXXDZI2TLqXD/tqTZGHj/cF0YcMq0fXP1TpWYkM2ME=;
        b=ZIKx0ul4qHGHX87B5nVVGNECSI7xEXHDbsbHkRdgCZwIIHwmDmtgMva55fb+uuxv7I
         CbkvEgHjTYOVItavoNwPBqVV9CgffjtegXbc3hCXwZF/I9/a7OoS8zB1+qBqLoN5aiGK
         9NQumhiv7xnOCSvooxmjUxgOSSLhXNMUfDHAwUow7yLlyLJ9uy5UrJmG+H5YVL3Su209
         4rxiphKS6I62cVeMbakyxbZ7iB0TDIbZW6FqMw7ssDWowyDAxflvUEhtzkmyGEoDqOQs
         D73+MqDK3W7D5+lnO0Tb/tnNpqE30KKAPaSR5/x0OY2c/FpcODvngnJZzNc1/JCCluiE
         DNwg==
X-Forwarded-Encrypted: i=1; AKwUvBwVOgVrfci/loVH6zziO6dWqYnc1E7DIABMSeoe4V/JdwwM2KXdxBF1SmpTr01Ljy7VBp0972zrvQHE@vger.kernel.org
X-Gm-Message-State: APuU4Z85qtUxXA0Ds6sl9BbHZ8tlLlzis+UgSGMmJqNDTnc3mguMZRE2
	JlauyzhzJd4V0ivUGGeh8WZhTWmcy5QLxcyt3N2ljP/f9+BrJy+V8Sd/csT4Wm836IQGcqcEQR4
	6kbWlUU+SYQ==
X-Gm-Gg: AYBFou1MyUdICa20XPutJZlMLfMNmC8iDvOdduxdijT86oDCq8eNy4QH8xiL5ojHkqU
	anuuX49BY28KQX3VacC1lvsJnaehscUoTobSe65SUXzcADoEMxs0d5Uz1Eu/r2HORL27YQ425XA
	fLvyD8FcLXLSoFlJMj34K6waFTHLEyMsQKSYRHu9f5HrbKVl2pjMKhi65Z7ijdKs5m5vpBcV+Bw
	lry5TLBMjrVFZQOuUTasB1IOC3kuyDO7OEIsQVMLHDZFZVVv2C8hBe4Wunz0pmUZILfGF0sKU/8
	9UgJzV15/fEG/9qRDIzgD5tp3p7iIUFUoY5WJ61BRNWHGNs4Lt/EawdZOxTXvSOcnfV7Yd5DA7x
	4WDnheh7eCLE+Q4ZovpmGgMtVQw4sEyuq5DC7CjfMtPN6AuPALFZ2JjgEsIZCE7PcAEDvJhgQ3H
	7LARq+KYBPzku37JwQdyqs7ljxRaghyrFWOwez262ehYsnFlV4uOR+GwPXSeFGPnQVsmT0IkzKt
	a1sYej+fP4re9hpG+CproQe2kReSeAgvvoDrrrWxY1q0xZdYmSu9KgICET10+gqYW1CtKyOMIqL
	1BNMxxSu3lMxliL7nvDC28mEB0R8eFdoepIA91iEQ05NrDVEBp++N4uG4j+wJJJEJoZaOcrXBSO
	FiGZKNlHjKwGzy1gUa4h9x4U=
X-Received: by 2002:a2e:be9b:0:b0:3ab:4e70:6959 with SMTP id 38308e7fff4ca-3aca5829c5bmr31588891fa.19.1793642816231;
        Mon, 02 Nov 2026 10:06:56 -0800 (PST)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acd5c2eee8sm807061fa.15.2026.11.02.10.06.55
        for <sparclinux@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 10:06:55 -0800 (PST)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5bfc32574e7so1754633e87.0
        for <sparclinux@vger.kernel.org>; Mon, 02 Nov 2026 10:06:55 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBxh7hQYGPPtZRYz/602fiGkV3Q2fUYLqkrhMHAK7rcGbDrVP5Dz9yxjuKGnD9iS3p0a6wxxPcZ1FL9g@vger.kernel.org
X-Received: by 2002:a17:907:d94:b0:c2d:c80e:8366 with SMTP id
 a640c23a62f3a-c4ca7426f6emr874452266b.0.1793642348398; Mon, 02 Nov 2026
 09:59:08 -0800 (PST)
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102-work-procfs-bugfixes-v1-0-59422ed3e465@kernel.org> <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
In-Reply-To: <20261102-work-procfs-bugfixes-v1-1-59422ed3e465@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 2 Nov 2026 09:58:51 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
X-Gm-Features: AclHuK_qZTBVsLQIdymgRHScSFenC6XsGggUDmcuOugjrSTbuVkeASUmC_hYPZo
Message-ID: <CAHk-=wiSA7-mqmAjTQDaU7UjUyWt0TxYwXHafL8ZAPudy+B_uQ@mail.gmail.com>
Subject: Re: [PATCH RFC 01/38] PCI/proc: don't truncate the position of config
 space accesses
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, 
	Josef Bacik <josef@toxicpanda.com>, Chris Mason <mason@kernel.org>, 
	Jeff Layton <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Eric Dumazet <edumazet@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, 
	Jonathan Corbet <corbet@lwn.net>, Christoph Hellwig <hch@lst.de>, Greg Kroah-Hartman <gregkh@suse.de>, 
	Joel Granados <joel.granados@kernel.org>, Kees Cook <kees@kernel.org>, Jan Kara <jack@suse.cz>, 
	Jan Kara <jack@suse.com>, linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, 
	linux-um@lists.infradead.org, linux-wireless@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
	platform-driver-x86@vger.kernel.org, coreteam@netfilter.org, 
	kexec@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-sound@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net, 
	jfs-discussion@lists.sourceforge.net, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, linux-hwmon@vger.kernel.org, linux-mm@kvack.org, 
	linux-sh@vger.kernel.org, linux-usb@vger.kernel.org, 
	samba-technical@lists.samba.org, sparclinux@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-doc@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-atm-general@lists.sourceforge.net, 
	Takashi Iwai <tiwai@suse.de>, linux-input@vger.kernel.org, linux-raid@vger.kernel.org, 
	linux-ext4@vger.kernel.org, linux-modules@vger.kernel.org, 
	linux-debuggers@vger.kernel.org, Chuck Lever <cel@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 06:22, Christian Brauner <brauner@kernel.org> wrote:
>
> proc_bus_pci_write() truncates the file position to an int. A pwrite()
> at an offset like 0xfffff000 turns it negative [..]

I think this would actually be better with rw_verify_area() just
checking a per-file maxbytes.

We already have that logic for lseek and friends - using that fairly
hacky combination of s_maxbytes and !unsigned_offsets().

We should combine s_maxbytes and unsigned_offsets() at file open time
into f_maxbytes and check that not just at lseek but in
rw_verify_area.

And then things like proc_bus_pci could set it's size limit in one single place.

Hmm?

                   Linus
