Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4499329E7C;
	Tue, 10 Feb 2026 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735018; cv=none; b=o/4B/Ee6+knR4FJa979ZoYTHsaPAzswNiG9+BS7UO06NXIsgzA2n3gnPn3pHWo9Or88PkCiNW9alMdviDOiiJc6+aOpT6HKAxqfdasEuzKKVg5bgMCM1e6TbDFTP3DYP1T1s1fsic0TxV7p8DbmshhjoGYrNIckdDYrZPtf3f24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735018; c=relaxed/simple;
	bh=YqNhqDan6ig5Eg8FfWiJBfgfNLXjdOvNf1vIcFRh5H8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mUcabf98pxqnSgbZgIwcHtyY5wmf9QxM1qAybfcD+3UZeGHRdYTnYb38FvSapDecH755gpPNW/NhB+MkcBvUbtN2tT8K9+L2Gkm2Wj0IzYOxy2SasGk3Jk+EyO5351qAd3AwTwpftdkr/RZhaoZds0PtcI0u/P/zU1QVrRSSgE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3ex2H+6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3ex2H+6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E02CC116C6;
	Tue, 10 Feb 2026 14:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770735018;
	bh=YqNhqDan6ig5Eg8FfWiJBfgfNLXjdOvNf1vIcFRh5H8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W3ex2H+6njMxfdkQtt4hfXP8xNYoYvUybMgCjkdXkRHCgKGQQudxPVj6r6Yq4X87J
	 qKQk4SPbkNxJjifgbRHYB0LIbaEKgNT1q7EAGZDodtYWpYtXt+PLTjreRRyYh0ZuB+
	 0XRCg3HQoTLA4LhyIdFuLZzdVr/SSw9/Ndr1QL+8Jlw7RzN+PIW/LRCopkpQH6Rwal
	 J24gsB2JhUZnmKMnS2yaIoTinVPtyDQgj4UHrG750qhTNlhIvb22kewZVjFgo8FCOz
	 fm9CerA5/tgkSQquoEeuWIQfz2qcaZ22uCaDVSNGjTWlgBnoS+i6Uy7a10vU89BO1/
	 TkxTBVLkg+EFQ==
Date: Tue, 10 Feb 2026 16:50:00 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 2/4] mm: rename my_zero_pfn() to zero_pfn()
Message-ID: <aYtFmCQQMYkZh7Wh@kernel.org>
References: <20260209144058.2092871-1-rppt@kernel.org>
 <20260209144058.2092871-3-rppt@kernel.org>
 <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>
Precedence: bulk
X-Mailing-List: sparclinux@vger.kernel.org
List-Id: <sparclinux.vger.kernel.org>
List-Subscribe: <mailto:sparclinux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:sparclinux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f15b363-a5e5-4a58-89b0-13b5112772b0@kernel.org>

On Mon, Feb 09, 2026 at 04:08:32PM +0100, Christophe Leroy (CS GROUP) wrote:
> 
> 
> Le 09/02/2026 à 15:40, Mike Rapoport a écrit :
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > my_zero_pfn() is a silly name.
> > 
> > Rename zero_pfn variable to zero_page_pfn and my_zero_pfn() function to
> > zero_pfn().
> > 
> > While on it, move extern declarations of zero_page_pfn outside the
> > functions that use it and add a comment about what ZERO_PAGE is.
> 
> I guess the idea of the extern declaration being inside its only external
> users was to ensure nobody would start using it directly, hence bypassing
> the overloadable helpers.
> 
> Should we at least call the variable __zero_page_pfn instead in order to
> warn people that using it directly requires care ?

I'd better move it back inside the helpers.
 
> Christophe
> 

-- 
Sincerely yours,
Mike.
