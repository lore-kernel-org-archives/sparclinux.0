From: Anatoly Pugachev <matorola@gmail.com>
Date: Wed, 20 Jan 2016 12:23:05 +0000
Subject: Re: Minor tweak to silo regarding GPT labeled drives
Message-Id: <CADxRZqzy4Ha+Ghsqa8j0Hw6wegM0q9W68=mmuxgjXLj3FjkFnw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <569D2C3E.5060608@oracle.com>
In-Reply-To: <569D2C3E.5060608@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jan 18, 2016 at 9:17 PM, Bryce <philip.copeland@oracle.com> wrote:
> I've been prompted by a couple of folk to pass along this minor patch for silo
> Newer sparc firmware, mostly in the T4 and above range, along with sun(vtoc) now
> support gpt labelled drives on the system boot drive (and theoretically some can
> also support msdos? not tried it)
>
> The problem with sillo is that it actively looks to see if a sun label magic is
> written but GPT has no such 'magic' and silo would moan.

having non-patched silo run on disk with gpt label (hardware is T5-2
server), breaks autoboot ( auto-boot?=true )

Boot device: vdisk0  File and args:
SILO Version 1.4.14

Fatal error: Wrong disklabel magic
boot:

I'm going to test git silo with this patch and report back tomorrow.
