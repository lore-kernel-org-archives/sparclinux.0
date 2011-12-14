From: Rob Landley <rob@landley.net>
Date: Wed, 14 Dec 2011 19:26:19 +0000
Subject: Re: Sparc-32 doesn't work in 3.1.
Message-Id: <4EE8F85B.9060209@landley.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4EE80891.70604@landley.net>	<20111214204225.7c8ec86c@sf.home>	<20111214.125443.973289484729064945.davem@davemloft.net> <20111214.131810.916491563666428853.davem@davemloft.net>
In-Reply-To: <20111214.131810.916491563666428853.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: slyich@gmail.com, aboriginal@lists.landley.net, linux-kernel@vger.kernel.org, tytso@mit.edu, sparclinux@vger.kernel.org, jakub@redhat.com

On 12/14/2011 12:18 PM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, 14 Dec 2011 12:54:43 -0500 (EST)
> 
>> The right fix is to simply teach btfixup to be able to patch
>> the 'restore' just as equally as it would patch an 'or'.
> 
> Try this:
> 
> --------------------
> sparc32: Be less strict in matching %lo part of relocation.

Yay!  With that patch, it booted to a shell prompt.

Thanks,

Rob
