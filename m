From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Sun, 04 Jun 2006 14:34:38 +0000
Subject: Re: Checksum problem on sparc64
Message-Id: <20060604143438.GD5295@bouh.residence.ens-lyon.fr>
List-Id: <sparclinux.vger.kernel.org>
References: <20060323223510.GA7683@sceen.net>
In-Reply-To: <20060323223510.GA7683@sceen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Samuel Thibault, le Sun 04 Jun 2006 16:32:15 +0200, a =E9crit :
> The last add doesn't take care of the potential carry into the 33th
> bit.

(which _do_ happen when the csum has its 16 MSB set, as Richard pointed
out).

Samuel
