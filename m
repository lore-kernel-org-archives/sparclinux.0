Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E417A309;
	Tue,  9 Sep 2025 02:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384164; cv=none; b=jc6dhGdO47yqv/GhhqOhMzVvwi4gSUGiuUc9QREzdi1BPuWt9SIYvqoJ5hLgsddC+iWznLip/i1CvOu15hYRvbf7N61RBcu/9tK3qFgrxLKUAJ84AIcFuH5ZL3++siRmwIgENyeXGFYhjLWI1DSASArYiMsWtvWhyRQrLcCQZcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384164; c=relaxed/simple;
	bh=xKkpvDQWGBF1SNQMUrwQak6dbS7+Kaawp2n8VZWz+M4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PBi2ig9f5VDJ1ck5k4TBq15CdBDC6yICULAI1EQuTr08lBzvTdr+Kg+ebYdzw8dkI5hZwtLMo4/1sNnLsGZTtq8W4XcgE8Ka08VpUKG1uRO7Av+3/cFlUA1Z1clUpgwYXXgvTGYDau7PkB2sk9ZTI9oIVAPrzfy/Gmf9zF5+5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Ji+MvIMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ji+MvIMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07D67C4CEF1;
	Tue,  9 Sep 2025 02:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1757384164;
	bh=xKkpvDQWGBF1SNQMUrwQak6dbS7+Kaawp2n8VZWz+M4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ji+MvIMJjnCzrm7JJouZjdcrryC08RI/Y6GwKlm7FmWFFjuLZhlIDnztPmdSccd+S
	 XVAieks/t16/1DrhnW8YjQQ5RGHB69prkFM4EIJDH7kM1ar3vtf0c34VBvQ5OpxJXk
	 jgytnzkbwbD6aEm0RBJgjRvCRYzqKtlr879Qt3uE=
Date: Mon, 8 Sep 2025 19:16:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, Alexander Gordeev
 <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, Boris
 Ostrovsky <boris.ostrovsky@oracle.com>, Borislav Petkov <bp@alien8.de>,
 Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar
 <mingo@redhat.com>, Jann Horn <jannh@google.com>, Juergen Gross
 <jgross@suse.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Suren Baghdasaryan <surenb@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vlastimil Babka <vbabka@suse.cz>, Will
 Deacon <will@kernel.org>, Yeoreum Yun <yeoreum.yun@arm.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 sparclinux@vger.kernel.org, xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 0/7] Nesting support for lazy MMU mode
Message-Id: <20250908191602.61160a7990b9ea418de758c7@linux-foundation.org>
In-Reply-To: <20250908073931.4159362-1-kevin.brodsky@arm.com>
References: <20250908073931.4159362-1-kevin.brodsky@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Sep 2025 08:39:24 +0100 Kevin Brodsky <kevin.brodsky@arm.com> wrote:

> The main change enabling nesting is patch 2, following the approach
> suggested by Catalin Marinas [4]: have enter() return some state and
> the matching leave() take that state. 

This is so totally the correct way.  Thanks.
