From: Elad Lahav <e2lahav@gmail.com>
Date: Tue, 10 Mar 2009 12:00:58 +0000
Subject: Re: Signal handler arguments
Message-Id: <49B6567A.9090703@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <49B543AF.4090902@users.sourceforge.net>
In-Reply-To: <49B543AF.4090902@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:
> From: Elad Lahav <elad_lahav@users.sourceforge.net>
> Date: Mon, 09 Mar 2009 22:54:26 -0400
> 
>>> Yes it says ucontext_t and sparc is the lone-wolf out here.
>> It's not a lone wolf, it's a misguided one.
> 
> Well, whatever it is it can't be changed without breaking
> everything out there 
Do you mean breaking all the applications that use the third parameter 
as a sigcontext structure? Can you point to any? Remember that this is 
an undocumented deviation from the POSIX standard, unique to 
Linux/Sparc. Somehow I have a feeling that very few programs are aware 
of this feature and are using it.

 > if that's what you are suggesting happen.
I suggested that this deviation should be either changed *or* documented.

--Elad
