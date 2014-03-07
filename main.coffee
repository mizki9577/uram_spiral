# main.coffee
# 変形ウラムの螺旋

CCW = 1
CW  = -1
RIGHT = 0
UP    = 1
LEFT  = 2
DOWN  = 3
PI2 = Math.PI * 2
NEXT_COORDINATE = 16

class UramSpiral
	constructor: (canvas_element, @n=1, @spr_orientation=CCW, @direction=RIGHT) ->
		@canvas = canvas_element.getContext('2d')
		@canvas.fillStyle = 'rgb(0,0,0)'

		# (0, 0) をキャンバス中央に移動
		@canvas.translate(canvas_element.width / 2, canvas_element.height / 2)

		@x = 0
		@y = 0

		# 進むべきマスの数
		@will_proceed = 1
		# 進んだマスの数
		@proceeded = 0
		# 旋回回数
		@turned = 0

	draw_spiral: =>
		# 点を1つ描く

		# 描画
		@set_propaties()
		@canvas.beginPath()
		@canvas.arc(@x, @y, @radius, 0, PI2)
		@canvas.closePath()
		@canvas.fill()

		# 次の点の座標を求める
		@n++
		@proceeded++
		if @proceeded is @will_proceed
			@turned++
			@direction = (@direction + 1) % 4
			@proceeded = 0
			if @turned % 2 is 0
				@will_proceed++

		switch @direction
			when RIGHT
				@x += NEXT_COORDINATE
			when UP
				@y -= NEXT_COORDINATE
			when LEFT
				@x -= NEXT_COORDINATE
			when DOWN
				@y += NEXT_COORDINATE

	set_propaties: =>
		# 点の色と半径を設定する

		@radius = 0
		for i in [1..@n]
			if @n % i is 0
				@radius++

		@canvas.fillStyle = if @radius is 2 then 'rgb(255,0,0)' else 'rgb(0,0,0)'
		@radius = if @radius is 2 then 2 else @radius / 3

	loop: (limit) =>
		while @n < limit
			@draw_spiral()

document.addEventListener 'DOMContentLoaded', ->
	uram_spiral = new UramSpiral(document.getElementById('canvas'))
	uram_spiral.loop(4096)

# vim: ts=4 sw=4
