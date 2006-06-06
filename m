From: Marc Zyngier <maz@misterjones.org>
Date: Tue, 06 Jun 2006 10:05:57 +0000
Subject: Re: [PATCH]: Fix D-cache corruption in mremap()
Message-Id: <wrpzmgqfvju.fsf@wild-wind.fr.eu.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20060601.175258.41634623.davem@davemloft.net>
In-Reply-To: <20060601.175258.41634623.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Just to add yet another testing point.

The latest git runs nicely on my oddest sparc64 system, a Netra AX1105
(a strange crossover between a Blade-100 and a Netra-X1).

Thanks a lot for fixing that, David.

	M.
-- 
And if you don't know where you're going, any road will take you there...
