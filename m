From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 18:17:20 +0000
Subject: Re: [PATCH 11/11] sparc: unify ptrace.h
Message-Id: <20090101181720.GA8573@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1230595090-23982-11-git-send-email-sam@ravnborg.org>
In-Reply-To: <1230595090-23982-11-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The two ptrace.h implementations are very alike but
> the small differences required two set of ifdef/else/endif pairs.

This patch is bogus. It missed to include psr.h for the
sparc 32 bits. Will send an updated patch soon.

	Sam
