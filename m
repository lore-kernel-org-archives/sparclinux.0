From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 May 2007 18:41:39 +0000
Subject: Re: Linker script cleanup / consolidation
Message-Id: <20070529184139.GA5846@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20070524200934.GB1109@uranus.ravnborg.org>
In-Reply-To: <20070524200934.GB1109@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, May 28, 2007 at 11:00:29PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 28 May 2007 20:53:36 +0200
> 
> > First off. I tried building a sparc64 kernel from -linus using
> > defconfig and got no section mismatch warnings.
> 
> Turn on SMP. :-)
In trampoline.S moved all code to .init.text and got this:
WARNING: arch/sparc64/kernel/built-in.o(.sun4v_1insn_patch+0x8): Section mismatch: reference to .init.text:
WARNING: arch/sparc64/kernel/built-in.o(.sun4v_1insn_patch+0x10): Section mismatch: reference to .init.text:
WARNING: arch/sparc64/kernel/built-in.o(.sun4v_1insn_patch+0x18): Section mismatch: reference to .init.text:
WARNING: arch/sparc64/kernel/built-in.o(.cpuid_patch+0x0): Section mismatch: reference to .init.text:

It is trivial to ignore all references from a section named *_patch to .init.text
But grepping linker script files for all other archs this does not look like
a common namespace.

modpost has today following list of sections that may reference .init.text
without causing a warning:

	const char *namelist1[] = {
		".init",
		".opd",   /* see comment [OPD] at exit_section_ref_ok() */
		".toc1",  /* used by ppc64 */
		".stab",
		".data.rel.ro", /* used by parisc64 */
		".parainstructions",
		".text.lock",
		"__bug_table", /* used by powerpc for BUG() */
		".pci_fixup_header",
		".pci_fixup_final",
		".pdr",
		"__param",
		"__ex_table",
		".fixup",
		".smp_locks",
		".plt",  /* seen on ARCH=um build on x86_64. Harmless */
		"__ftr_fixup",		/* powerpc cpu feature fixup */
		"__fw_ftr_fixup",	/* powerpc firmware feature fixup */
		NULL
	};

	/* Start of section names */
	const char *namelist2[] = {
		".init.",
		".altinstructions",
		".eh_frame",
		".debug",
		".parainstructions",
		".rodata",
		NULL


So adding a third section that allow references from sections named *_patch is no big deal.
Let me know if you stick to that namespace and I will add it to modpost.

	Sam
