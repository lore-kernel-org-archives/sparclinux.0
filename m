Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC2844E042
	for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267894; cv=none; b=ORNNC/zzhQzLhoNR7cPSuZqxHDUE6IMpEfaUg4xHWazJ3L7mk9giyDaD7AlDUs4fnO0U0PpwfdzEGvusie3s5r6kIpynk+T126Hym723nc0Sfb6W5PLfYgBCVmTkg1mvIKXxOQcg0LQ1wqP5Wp/Asw9mnAH4En0QAJkcK+iklDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267894; c=relaxed/simple;
	bh=Y6dfgoDu9ENyHz35342iESy0PYqePxl/sIn9jSurkUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k82jQ0OmtjemQNj0cHBnyrwKaxGxKBGWp0JpZeIsFZ1FVX8Wu3UmsQAolOY334Aal6YNfkHV1O6NGMONctFh8blThgaXE3w6QT/64vPALPCU5Z3Y1cw9iGF1M4OX9kcA3QxH1JSoQd5LqOdsN7yXU7kdh7R89KbVQdQqMozsOJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=DELaQ6H+; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="DELaQ6H+"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530280b8234so211561cf.0
        for <sparclinux@vger.kernel.org>; Thu, 24 Sep 2026 09:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1790267891; x=1790872691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=DELaQ6H+GoqYKhSPbbw83I2UghjOPLUKt/HJzwYXOl5vd4By1b/ewKsZIbd9ahXhZb
         TJDLBT2drAnq8j1D4gtZjKdZE54vfhHIW07z7SMjyhNrpJZ88lIXL27llafwJKgt7Hvw
         zeqWn52o1fsiwmzoo4rrDQZv3h3IiFJnFO2iuBnkUsGA3ktjvtFHA3Jr6K2ZEcGMg8M1
         1di2ZTIAJ2yTB2V6zmlctv6zG6tcG5IvMF9RkWmI06r7tX+skZxDuVThBB0MSr3NZe3S
         B2+XxiOTA95Xk/3/+mlBZ2rpvQSIcAx9lD43yFxhcrOBvTesr5mE416XkZK5Fw1vsdLx
         5Q7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267891; x=1790872691;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LuPrvXBzY5FQ+f/5fzbveR9yF272P1V2+jsIcGJNdC0=;
        b=LqpJWxrNClYRw0l0obsdf180Rhmb4K0nb6Fs6OXTXQOozJcQiIjaDTecinRqxaT+IR
         k6WVjE6JPVllnWPF68k5M/1RmW0cZU6oZ8s2Iv5xEes30KzY5k5WBPybIPw5JNktBxUN
         N/FxsbpJwQFly59b6r21vv3gmqB8XylffCoS3uYCtxDBl1OcI6PDjb8jwNtRb42jNZz4
         0pFrH2kX2l2a1CK/WdAHxLlvF0AJMemUagfxXeBGaOugph/4KkL5zIj6h2Qc1ek3jbRG
         LdNI5wOy2rFue6PXRfSauxc1JbcqCx4Bkh8rheq0ZjnF8OvoLcM5bPt8yZ/uYEVsmoNU
         YTTA==
X-Forwarded-Encrypted: i=1; AKwUvBxBc6+Q3T/IkM/i8njLsDHdQAhIGIsGufxW0OrM8toppGtkLELLIinhZh0q1fJAIn3X51dUGQKJMdgj@vger.kernel.org
X-Gm-Message-State: AFuF++mvbj1v+fYMzWKFhIr85LwyvY2zhXnJp5/bZD6XtacNFNDLjTEY
	XV/7NPFiwgus2qvQQmK5ALteeN8KKUdODRc1MGutQNThJNJAB7nUt7B4cecYsJ/5EVE=
X-Gm-Gg: AYBFou1JgIWlhOAfwN62CMqz5HswbOqfc1Y/aBf7IlPqxtHgaHPJ3LOJeDmBuqlDeYM
	yQUN5glm4DXiaQ3Nj/s2ZhiX2ueHpEKJoJ4Wx8ij3nslChzTf8zK3pBs3e5Rf5WJbzwbIDkRr1r
	0zMclBMzB2xYqxR7sjbgVPv14NkwWqjHCDb7Xl3+Py80171E1mujQDQTeGvC/cABCQ6+CsrWOyu
	EMxuq4U0T9t61LSxij46CznpdRU29hXCwowSAyHDfvMsexUx3jr7z+u9s2Bn7UJfjSA+HevRRLd
	qShj45xg9VK22c7BWVXXB6apswTxd898/Yp4rCk6SpI7cqm3KBss52P0GAlkNBG1XEOucF176k3
	2dxBwcXbjghf8yj9oihrVawhTUzh2sUk/a9p2oADEUBD6azdpwPNau40YKy0X2EQWLDNxcAiVd8
	na4dz1DQtO+b3/ANRKC29va+ttbsEDM4dLBQ3mdMUgxyUOqQpgIfS84hsnEboLA8W6WonPOw/2+
	La6w0AIx8cDbrjvEfURrfogHn9F3NmRAH73stKKk5chrYBxVD5kVcg=
X-Received: by 2002:ac8:5743:0:b0:530:d860:ffba with SMTP id d75a77b69052e-532fe9f05bamr29797891cf.6.1790267890993;
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532eb32f6aasm45064551cf.16.2026.09.24.09.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:38:10 -0700 (PDT)
Date: Thu, 24 Sep 2026 12:38:08 -0400
From: Gregory Price <gourry@gourry.net>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-rdma@vger.kernel.org, selinux@vger.kernel.org, linux-sound@vger.kernel.org, 
	bpf@vger.kernel.org, linux-scsi@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-trace-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, fuse-devel@lists.linux.dev
Subject: Re: [PATCH v3 03/40] mm/vma: introduce and use
 vma_[flags_]can_merge()
Message-ID: <arVRqJZkql6sGunt@gourry-fedora-PF4VCD3F>
References: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-0-4583d8a23bca@kernel.org>
 <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917-b4-mmap-prepare-vma-flag-sanify-v3-3-4583d8a23bca@kernel.org>

On Thu, Sep 17, 2026 at 05:22:12PM +0100, Lorenzo Stoakes (ARM) wrote:
> Replace the open-coded VMA_SPECIAL_FLAGS check in the VMA merge logic with
> two new functions vma_flags_can_merge() and vma_can_merge() and update the
> merge logic to use the former.
> 
> This abstracts the check and expresses it in terms of the desired behaviour
> rather than an arbitrary and confusing VMA flag.
> 
> This also lays the groundwork for making further improvements in VMA flag
> usage.
> 
> Also update the userland VMA tests to reflect the change.
> 
> No functional change intended.
> 
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

