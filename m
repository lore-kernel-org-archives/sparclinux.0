From: "Blue Swirl" <blauwirbel@gmail.com>
Date: Sun, 21 Sep 2008 12:52:26 +0000
Subject: KVM for Sparc?
Message-Id: <f43fc5580809210552sdf3ee24w8922ac25f93fb75@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <f43fc5580809210538r38a29d8dpc74342a2bceea109@mail.gmail.com>
In-Reply-To: <f43fc5580809210538r38a29d8dpc74342a2bceea109@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kvm@vger.kernel.org, sparclinux@vger.kernel.org

Hi,

 Sorry for cross-posting (and because I used the wrong address in the
first time for KVM, sorry for the duplicate on Sparclinux).

 Sparc host support for Qemu is getting close
 to ready, I can already run a Sparc32 system emulator on
 OpenBSD/Sparc64 and there is some limited success with recent glibc on
 Linux/Sparc64. Otherwise Sparc32 target emulator is pretty stable.
 Sparc64 target emulator can boot from several CD images, but crashes
 pretty soon.

 But I think we could already start early drafting of what KVM support
 for Sparc32 and Sparc64 would mean. Because of certain problems in the
 V9 instruction set design (V8 rett reuse for example), it may be
 difficult or even impossible to use an accelerator if the host and
 target instruction sets do not match.

 Other possibilities include porting kqemu or Xen, but I think KVM has
 the brightest future.

 I'm interested in pushing the Qemu side forward, but obviously
 something needs to be done by the kernel/KVM people too. What is the
 feeling on KVM and Sparclinux side?
