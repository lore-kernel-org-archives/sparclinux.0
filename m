From: David Miller <davem@davemloft.net>
Date: Wed, 14 Dec 2011 19:13:16 +0000
Subject: Re: Sparc-32 doesn't work in 3.1.
Message-Id: <20111214.141316.931101347023790867.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111214.125443.973289484729064945.davem@davemloft.net>
	<20111214.131810.916491563666428853.davem@davemloft.net>
	<20111214215516.26ffe884@sf.home>
In-Reply-To: <20111214215516.26ffe884@sf.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: slyich@gmail.com
Cc: rob@landley.net, aboriginal@lists.landley.net, linux-kernel@vger.kernel.org, tytso@mit.edu, sparclinux@vger.kernel.org, jakub@redhat.com

From: Sergei Trofimovich <slyich@gmail.com>
Date: Wed, 14 Dec 2011 21:55:16 +0300

>> sparc32: Be less strict in matching %lo part of relocation.
>> 
>> The "(insn & 0x01800000) != 0x01800000" test matches 'restore'
>> but that is a legitimate place to see the %lo() part of a 32-bit
>> symbol relocation, particularly in tail calls.
>> 
>> Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> Tested-by: Sergei Trofimovich <slyfox@gentoo.org>
> 
> Was about to send exactly the same. Thanks!

Thanks for testing Sergei.
