Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88BF1851;
	Sat,  2 Mar 2024 06:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709361378; cv=none; b=JIZIsvlQBFqzaMQjOwuY9Zs4d5qT+bAte+tT0hajncYo46fjqj4F3c1EVtrbruFWpYOH0YQoY+eKAhTQa25xHHGvr8EZZ9ImAWRnRUhDoAY1kyUxUsynW1p5JCDwNZs3KA+wMkgRMEPCU7+9SmjNckDZTH+FunzsFuM2u1eHwwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709361378; c=relaxed/simple;
	bh=n1RlqE3od9xggT7kkb9tO7DOH65il1hmP2jYmrr48k0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ky6XhdeSZiXGayyV70eg8WxtZXeo2l2ZRt5IMtsdfLqCrWA2dKqn19ENe9xnZvD3tyJfr+1yjP6AUD4oBbTQYDUqSVJ8Nuj1UAbIE8U4cM38K/JOlCnbPENjV4UoGkp/nm7uoj6vqTU5Bwb6bPlENKNbxNKA6Jk4ImR27EWjDFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b=gjI5GuPX; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=deller@gmx.de header.b="gjI5GuPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709361319; x=1709966119; i=deller@gmx.de;
	bh=n1RlqE3od9xggT7kkb9tO7DOH65il1hmP2jYmrr48k0=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=gjI5GuPXz5XI0/YnvqcpdB5nO8i7a58BBoHZaBXB3pG8HD0b8kNG4qeefZwiujk8
	 7/LK/ZTCxBzcqpmmtLdGos9PFf4z5azHHxVpaabFa1se6J915fFXpdKEHBp9WkrN5
	 rqmZmi5IBjOjX6f//4E7nELLO2xI/HjEf6gxriWlfi3q1tuFExb58oJSyFD0onUbh
	 zA9Hn5rFK5xHHairQJhZWCKT7El949S67Jyu8SvDrxo9AmvSRVRm2T77h2HMMQavT
	 DJZdMClHO8H4/noe6e/Dj5IsbZP+4uFbza9q/st4F9Yx7UVd09aWQ31JXlpNYEedL
	 eqIu/RPj2LZXYuhckQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.144.221]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N4hzZ-1qhMwK30X1-011foK; Sat, 02
 Mar 2024 07:35:19 +0100
Message-ID: <ce73b0b4-a720-4e1b-8ab9-1990d76a6425@gmx.de>
Date: Sat, 2 Mar 2024 07:35:15 +0100
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2.1 06/12] parisc: Use initializer for struct
 vm_unmapped_area_info
Content-Language: en-US
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, bp@alien8.de,
 broonie@kernel.org, dave.hansen@linux.intel.com, debug@rivosinc.com,
 hpa@zytor.com, keescook@chromium.org, kirill.shutemov@linux.intel.com,
 luto@kernel.org, mingo@redhat.com, peterz@infradead.org,
 sparclinux@vger.kernel.org, tglx@linutronix.de, x86@kernel.org,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 linux-parisc@vger.kernel.org
References: <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
 <20240302001714.674091-1-rick.p.edgecombe@intel.com>
 <20240302001714.674091-6-rick.p.edgecombe@intel.com>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <20240302001714.674091-6-rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dYfQuAJ0dI6WtakBVUawNGe/9ww+E96Dlpe3KX13ezxNILf+Zhp
 ZHPdAUaggpSIHTNC/v2BhgpJ1Bbjon6FkJyryTj+p2TglDE+MQ0naPH2K8MmwpgEobkVw97
 IILWtja45fzojUKUF4KGcvmITSy4+BLYuc7HWemlxb4zek3PnH6K4yve+Omc5WP+u1jr6IJ
 6gfxeseg4Klb38rkUCZGw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TaCfPMsrJJ4=;LArncDk99WRXOMDCfho9nFtgqpx
 9QEMvq+Nh2RuPNU02vKe7Mmbm78WIraXJrvmxC5z80RC3c5426T+RM0jsSf1pHtryPf5jPWT+
 zci0wbDDVmTyyIEjL2mNrGefXVkkfOLb3sod13FPc99bTvbWQQ0s/+urh9fGHBi0N/78kIDjZ
 wlcwluPvRnpRXB2mAxkTx8ae8yemrebezqDhAvWp3Uau6uT4960BSq66Awvl7fIbbeJSxpLGc
 SlEpShNKCSDVfRx+YB6VEflRS86erZ9pcf/kPUoOIxnEzSesD1E6q8xLj5NgX8YnPiUKIzWJR
 eopgRJhImOGeQv4473Qmto7xV80lSFHtjyDRcQmVWILnuTyo9SHjSjIr/F032fU5nIyZJrdJQ
 8B3p9+DoDDqOPacCBHtsJ/GUIvXwJB5H4V6//nYpkY3Hbsj9yx3JqFhWvijzWsxSnnnpr4/AI
 8Hr9toBqoY08ThYx1I+9F/wKD9HL4XcziY+2JT0yVSKqt0h0HQEQt8kPWX4vhZLo9lDfuQB0L
 FLblEThyqMz4WJJnEnhhTiY7bL0Twf1fHycf732flBNLx9B1GFPzV03rfXFddLeBYZIrtfKCC
 U4k7PgiPKzOva5kNHuUeDebKa2aktcOeIpAwCcS5MU9AXbpImPWrpR/YW2dbituQ/XMf0WjfL
 /gPiyQW5sWXkFa6QElqTLqNv2llOQvZliLnK/bnkNuv62KWliluU1l/YFs9zGBi81eDIDC9YT
 2i6RjHAb9v1QZhjFUo5UMhQNqWfO6me47NdVInd3eu2XrhNyx76Um6q40wfdCibWnuFEj7Ima
 8BYrjlRWmNZMdrMFwyqkDYvGZwAe6Kh0Ol2MaqNdG2ySA=

On 3/2/24 01:17, Rick Edgecombe wrote:
> Future changes will need to add a new member to struct
> vm_unmapped_area_info. This would cause trouble for any call site that
> doesn't initialize the struct. Currently every caller sets each field
> manually, so if new fields are added they will be unitialized and the co=
re
> code parsing the struct will see garbage in the new field.
>
> It could be possible to initialize the new field manually to 0 at each
> call site. This and a couple other options were discussed, and the
> consensus (see links) was that in general the best way to accomplish thi=
s
> would be via static initialization with designated field initiators.
> Having some struct vm_unmapped_area_info instances not zero initialized
> will put those sites at risk of feeding garbage into vm_unmapped_area() =
if
> the convention is to zero initialize the struct and any new field additi=
on
> misses a call site that initializes each field manually.
>
> It could be possible to leave the code mostly untouched, and just change
> the line:
> struct vm_unmapped_area_info info
> to:
> struct vm_unmapped_area_info info =3D {};
>
> However, that would leave cleanup for the fields that are manually set
> to zero, as it would no longer be required.
>
> So to be reduce the chance of bugs via uninitialized fields, instead
> simply continue the process to initialize the struct this way tree wide.
> This will zero any unspecified members. Move the field initializers to t=
he
> struct declaration when they are known at that time. Leave the fields ou=
t
> that were manually initialized to zero, as this would be redundant for
> designated initializers.
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
> Cc: Helge Deller <deller@gmx.de>

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge


> Cc: linux-parisc@vger.kernel.org
> Link: https://lore.kernel.org/lkml/202402280912.33AEE7A9CF@keescook/#t
> Link: https://lore.kernel.org/lkml/j7bfvig3gew3qruouxrh7z7ehjjafrgkbcmg6=
tcghhfh3rhmzi@wzlcoecgy5rs/
> ---
> Hi,
>
> This patch was split and refactored out of a tree-wide change [0] to jus=
t
> zero-init each struct vm_unmapped_area_info. The overall goal of the
> series is to help shadow stack guard gaps. Currently, there is only one
> arch with shadow stacks, but two more are in progress. It is 0day tested
> only.
>
> Thanks,
>
> Rick
>
> [0] https://lore.kernel.org/lkml/20240226190951.3240433-6-rick.p.edgecom=
be@intel.com/
> ---
>   arch/parisc/kernel/sys_parisc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/parisc/kernel/sys_parisc.c b/arch/parisc/kernel/sys_pa=
risc.c
> index 98af719d5f85..1f0b60766aac 100644
> --- a/arch/parisc/kernel/sys_parisc.c
> +++ b/arch/parisc/kernel/sys_parisc.c
> @@ -104,7 +104,9 @@ static unsigned long arch_get_unmapped_area_common(s=
truct file *filp,
>   	struct vm_area_struct *vma, *prev;
>   	unsigned long filp_pgoff;
>   	int do_color_align;
> -	struct vm_unmapped_area_info info;
> +	struct vm_unmapped_area_info info =3D {
> +		.length =3D len
> +	};
>
>   	if (unlikely(len > TASK_SIZE))
>   		return -ENOMEM;
> @@ -139,7 +141,6 @@ static unsigned long arch_get_unmapped_area_common(s=
truct file *filp,
>   			return addr;
>   	}
>
> -	info.length =3D len;
>   	info.align_mask =3D do_color_align ? (PAGE_MASK & (SHM_COLOUR - 1)) :=
 0;
>   	info.align_offset =3D shared_align_offset(filp_pgoff, pgoff);
>

