Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794726812;
	b=hcwlEWjwbH/jp9i3Yn7E1hyi5IrOJPGoiEOd0VAiOnA9oOfMvdT5SAolg08RumCBXeiW
	 gzYESUpNRE3Kb/UvjjtLoi0pkoOHUH9h+HpxIkd4t4IywAy/1vC6XyYN0DmnY1qSls/zQ
	 Dj7htR/PAta5DadGa2N/FwypZymmmz8Vlxb5ezZ/KOn4yiVhhvNHXgpHbzO6/uUqZFff+
	 3oGRfmUs3+N/8yEWlM4zoo4hy18Tsxy8Q3FP4g0x9Ngtcdn/tMjs9IicrzdtTtAREeGK/
	 dRGhIUQJHYFqivADjXbnLYsPcFlgd6CL6nNwczEUbJrU56Cnaf9rs4jumwSoRpiE1aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794726812;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
	b=gOmTvrpGD5iGXbLbjYmH8/rXq/7BiSrCYd+CfIlwsACayUMNlKzDqQ8aG1O9roUSunx8
	 iHHxtW57dlaIfFlENaXaEkPOG1TdPaOUkHd36QfsBEsC4Oe+BW5woL9Inlzcdm38gjRep
	 qr2t17BGM2fwjgtJlctn0PhnoagSFrdRzVI1mxJEGEb6BusMceJDiqe+aFNs3k/Ky6RlL
	 lt+iOcnvLxTI4t63fFPuhDFKEToctuw+JLBAxXx2cwm1ozZdhN0pcqPapf9v0qMdvWXL0
	 NbfNOHqL045ijFa5/1UdGHi1Y8J/kTC6dVql4hzNFh59wZpEVkjiPrnQkykPW961M/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0EKiv+f;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF3D606A334
	for <sparclinux@vger.kernel.org>; Sun, 15 Nov 2026 07:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6DF3D606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f0EKiv+f
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1a2761c69fbso2761592c88.0
        for <sparclinux@vger.kernel.org>; Sat, 14 Nov 2026 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794726811; x=1795331611; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=f0EKiv+f25sXRcQmBoiK+WsCsclD9PQHa+U5z3sGf3KR1sS3ZNEEroqRh6RNiac07P
         vGJPEugwLNmQaWqJhCPHikaN8XT33PRVwWCxE9PqkkLJA6butk39sYE2ryU8qCsIMdGI
         yo50td1Os6it0j1WrNa5HxnLEw4W7aO/qgSsYPJply/RpIro6UCSg0Mbr4ks/thyRkDc
         jq1OBKLqGUt/bM6QVBsbrIsF1mbjoO/AbvtSri1zHl8+S2Sf3KoNhgqJldsJW2yIuTc5
         6FJrXgJQKS6UwdWBKS3YQ4l597qJpRKbmN+vGilzta6Rl47F1I/gy3R+i3U13Lj6DU+d
         z+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794726811; x=1795331611;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i0sztYeDoa78GRxByi5DPGRDZ13zK/I8mczcB1W5Z+o=;
        b=cDFQ/qS73DHOIwDiWpv5K0hhsAJxUJsaPJu0MWSRJXbtx4Os+t9E0Qq+XPzf56+AXn
         70bH7ARErH2DxHwcM+3bD4pk8n88YS0i3CvxqfbkvH3jxh3L2YHmYXBfsKFF84c2tEof
         e/DbsebnB/xODAb2Xo6cU9X+LDRa4ANb3m/OSOc6cwNt7hRLdJESkZr4xvLI6C0dpfb+
         AloSTljS56ggO0kW7lQGtl0QXYmavElqIuj40d2FiaktJDtRlYzGUjaZeEVTfmnCws0Q
         92l3m9gg4eRBMVMAMz9usPsYBlZ9L6Yys72laZD+J7A/GwZf0kdlsIYoBr5iY0bcHuDD
         NnhA==
X-Forwarded-Encrypted: i=1; AL+hErGN4CvlbpSsnEQVjfH3urX1SegP8KQUBEe/HPsDc0r7kOVgRYop+cz8E55hv2qXgM2TcuoG9PxarWoc@vger.kernel.org
X-Gm-Message-State: APuU4Z+9hWssankFcBEJnmm414A7BSjLdqKDvdQAo8C6/bZrOhkiaXY0
	MaAVTY7uUMz62c4YeFHu5Jmi/XXPWiQGF2GNEyNIpv45f7ZoYDxeysSA
X-Gm-Gg: AYBFou03ahpVOsmS3Zox6nnqU9rhNdsOEhK3zYxwSIWVbl5R0Gv+tzmm/teeH9z70H+
	fhcPxNDL3gqb2UbbNHz6mztE7s7c+tjMD48v8fssJWpKNUyq+URea+bo+tNAmhtFrhdq4vdIRKd
	kDY7+OaOQlbiGc3ovM54E/NCajH/ZISn4q3D2L+lo8LgspBjgeWPY6zckNjxaC18lrP3UpUQi7w
	qrvJIx3D5Uo2k4m61ha0VxfbZkPUU2SJ64wfgAmFbMSD+PwVk4YZV5efLCeO15nJm/2eUoMwjNP
	+MFOA+hLpZ9Sm2pvAm5aHhulWoargldba7BTVG6HWrgj7gC/RUi6ggGHXPPZ2Umq3k5RoBWyHBT
	nr4ZC8KKPoLnrUL9g5vuEe+I6EWsWkEg4AYg8A7z+Fue0NQ8+dWtvf4lI0wXELx3bDa6mMIC3P4
	r6aOjpL91qubG98Fk8r/putqj0m45/su9wW4JsWFvuttHu26aUb0TPutG3mOXabkeCnJ/IIMbON
	1GNpn+bK37eC7utjh0FQZPtzLogK1E7UVGmoS54mp/58Qworb2ggfejqzh8hCcFDb7st1bwGCjp
	WmC5IKYpufpL/iMK/6c8BXQd7V4=
X-Received: by 2002:a05:7300:6148:b0:36a:7bb7:4609 with SMTP id 5a478bee46e88-37967dd7e1dmr11471490eec.34.1794726811302;
        Sat, 14 Nov 2026 23:13:31 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37956bad134sm27441185eec.27.2026.11.14.23.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 23:13:30 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, "David S.
 Miller" <davem@davemloft.net>, Dinh Nguyen <dinguyen@kernel.org>, Donald
 Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>, Heiko
 Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen
 <chenhuacai@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>,
 Liviu Dudau <liviu@dudau.co.uk>, Luis Chamberlain <mcgrof@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Nadav Amit
 <nadav.amit@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Peter
 Zijlstra <peterz@infradead.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, Russell
 King <linux@armlinux.org.uk>, Sam Ravnborg <sam@ravnborg.org>, Song Liu
 <song@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner
 <tglx@linutronix.de>, Will Deacon <will@kernel.org>, bpf@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 loongarch@lists.linux.dev, netdev@vger.kernel.org,
 sparclinux@vger.kernel.org, x86@kernel.org, Madhavan Srinivasan
 <maddy@linux.ibm.com>
Subject: Re: [PATCH RESEND v8 11/16] powerpc: extend execmem_params for kprobes allocations
In-Reply-To: <avlTdlK9ErlqVRYl@kernel.org>
Date: Sun, 15 Nov 2026 12:33:31 +0530
Message-ID: <4idi8tks.ritesh.list@gmail.com>
References: <20240505160628.2323363-1-rppt@kernel.org> <20240505160628.2323363-12-rppt@kernel.org> <3f7af771-87a7-4ae7-9919-bc4c23bd31c9@kernel.org> <avlTdlK9ErlqVRYl@kernel.org>
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Post: <mailto:sparclinux@vger.kernel.org>
List-Help: <mailto:sparclinux+help@vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
List-Owner: <mailto:sparclinux+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mike Rapoport <rppt@kernel.org> writes:

> Hi Christophe,
>
> On Fri, Nov 13, 2026 at 03:36:01PM +0100, Christophe Leroy (CS GROUP) wro=
te:
>> Hi Mike,
>>=20
>> Looks like I missed this change ...
>>=20

I didn't initially get what Christophe meant here. Then I came across this
reply of from him[1]. So looks like somehow between v3 to v8, something got
changed?=20

    On powerpc book3s/32, vmalloc space is not executable. Only modules=20
    space is executable. X/NX cannot be set on a per page basis, it can onl=
y=20
    be set on a 256 Mbytes segment basis.

    See commit c49643319715 ("powerpc/32s: Only leave NX unset on segments=
=20
    used for modules") and 6ca055322da8 ("powerpc/32s: Use dedicated segmen=
t=20
    for modules with STRICT_KERNEL_RWX") and 7bee31ad8e2f ("powerpc/32s: Fi=
x=20
    is_module_segment() when MODULES_VADDR is defined").

    So if your intention is still to have an executable kprobes, then you=20
    can't use vmalloc address space.

[1]: https://lore.kernel.org/all/1cb41761-29d0-5d33-b7c1-0ca3acaa810d@csgro=
up.eu/

>> Le 05/05/2024 =C3=A0 18:06, Mike Rapoport a =C3=A9crit=C2=A0:
>> > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
>> >=20
>> > powerpc overrides kprobes::alloc_insn_page() to remove writable
>> > permissions when STRICT_MODULE_RWX is on.
>> >=20
>> > Add definition of EXECMEM_KRPOBES to execmem_params to allow using the
>> > generic kprobes::alloc_insn_page() with the desired permissions.
>> >=20
>> > As powerpc uses breakpoint instructions to inject kprobes, it does not
>> > need to constrain kprobe allocations to the modules area and can use t=
he
>> > entire vmalloc address space.
>>=20
>> Using breakpoint means the segment must still be executable.
>> On book3s/32 VMALLOC segment is not executable, while module segment is.
>>=20
>> See commit 6ca055322da8 ("powerpc/32s: Use dedicated segment for modules
>> with STRICT_KERNEL_RWX")
>>=20
>> See report and fix at https://lore.kernel.org/all/ed03d290d440d579a81ae0=
b7de5243721291d903.1794543909.git.ritesh.list@gmail.com/
>
> I'll take a look, thanks!
>=20=20

Thanks Mike for taking a look. Sorry, I should have ccd'd you there, I
guess I missed it. However, the changes are these one here [2][3]

[2]: https://lore.kernel.org/linuxppc-dev/82c4973addebd82923c460cb44221f5b7=
6146afe.1794572365.git.ritesh.list@gmail.com/
[3]: https://lore.kernel.org/linuxppc-dev/f75f2cf97f44375fd2c8820e0caeab703=
cdb371c.1794572365.git.ritesh.list@gmail.com/

-ritesh

