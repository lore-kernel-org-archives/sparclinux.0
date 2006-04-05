From: "Daniel 'NebuchadnezzaR' Dehennin" <sparc@asgardr.info>
Date: Wed, 05 Apr 2006 21:55:25 +0000
Subject: Re: clone return code
Message-Id: <878xqju1pu.fsf@thorr.asgardr.info>
List-Id: <sparclinux.vger.kernel.org>
References: <87psjvu4wa.fsf@thorr.asgardr.info>
In-Reply-To: <87psjvu4wa.fsf@thorr.asgardr.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

Le 4599 Septembre 1993, David S. Miller a tapoté:
> The system call convention follows that of SunOS on which
> the syscall handling was based.  Return "1" in the %o1
> register in the child and "0" in the parent, and that's how
> the the call sites distinguish the two cases.

It's what I understand from arch/sparc64/kernel/process.c

> Why is this an issue?

It's not an issue anymore ;-) this behavior is handle now.

Thanks a lot.
-- 
Daniel 'NebuchadnezzaR' Dehennin
Récupérer ma clef GPG:
gpg --keyserver pgp.mit.edu --recv-keys 0x2A408F69
