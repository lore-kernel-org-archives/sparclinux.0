Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE2E3F9FB
	for <sparclinux@vger.kernel.org>; Mon, 10 Jun 2024 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004509; cv=none; b=Z5d7CeVnRLaNJdmz8tmQp/XUsvDsCb02oKx3b3xYRO54e7s/pukuybG2czZlzIhRCacQvjItRU46SORhnsgKzCclGGRJx+qfjje/EV6lU/MsuKAN2YCjtZ+uWDS4IYtcJslHcvUr12NbJQ0fU7xPKk/nUXwAqMPaZ0HzHjgIkaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004509; c=relaxed/simple;
	bh=QgUO4y4lJuyGEjk5BVlmE++YnHVFuvNVEthad6igBBQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ilq4AHw6mGVrbxF9fQvTQUKj1mBV3qPLLkkyxUrtSvUYd6SJu8DqWgn1WgbySRlLP6C1JA1sENDE1eiAyC/ny/YXaECNvZ/H9dC9SJGz5UGuMchRA58WQAKmjSRf7oUVv7kkVSLby/4CSp7BDaG23smU45deXxKKFI7u1FH8/gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:8ab6:b788:f6f3:c7ef])
	by albert.telenet-ops.be with bizsmtp
	id ZjUR2C00P0kaPLt06jURME; Mon, 10 Jun 2024 09:28:25 +0200
Received: from geert (helo=localhost)
	by ramsan.of.borg with local-esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sGZS5-002zEu-Ki;
	Mon, 10 Jun 2024 09:28:25 +0200
Date: Mon, 10 Jun 2024 09:28:25 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: linux-kernel@vger.kernel.org
cc: sparclinux@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.10-rc3
In-Reply-To: <20240610071049.933142-1-geert@linux-m68k.org>
Message-ID: <46c5a25-ea8c-4a1-5241-df88a9848a9@linux-m68k.org>
References: <CAHk-=wiK75SY+r3W5hx+Tt_bjhcSKPLdji-Zf_8HjikRPbn9wg@mail.gmail.com> <20240610071049.933142-1-geert@linux-m68k.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed

On Mon, 10 Jun 2024, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.10-rc3[1] to v6.10-rc2[3], the summaries are:
>  - build errors: +6/-1

   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x34), (.fixup+0x10), (.fixup+0x0), (.fixup+0x28), (.fixup+0x4), (.fixup+0x18), (.fixup+0x20), (.fixup+0x1c), (.fixup+0x8)
   + error: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040), (.head.text+0x5100)
   + error: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

sparc64-gcc5/sparc-allmodconfig
sparc64-gcc13/sparc-allmodconfig

   + {standard input}: Error: pcrel too far: 1095, 1074, 1022, 1020, 1021, 1096, 1126 => 1074, 1021, 1255, 1096, 1095, 1020, 1022, 1126, 1254
   + {standard input}: Error: unknown pseudo-op: `.al':  => 1270

SH ICE crickets

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/83a7eefedc9b56fe7bfeff13b6c7356688ffa670/ (all 138 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/c3f38fa61af77b49866b006939479069cd451173/ (all 138 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
