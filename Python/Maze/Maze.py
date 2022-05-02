import pygame, sys
pygame.init()

##SETTINGS
WIDTH = 10
S_WIDTH = 800
HEIGHT = 10
S_HEIGHT = 800



x = S_WIDTH//WIDTH
y = S_HEIGHT//HEIGHT

pause = True
frameRate = 5
clock = pygame.time.Clock()

grid = [[[False, False] for x in range(HEIGHT)] for y in range(WIDTH)]      #Wall/SNEK
grid[0][0][1] = True
screen = pygame.display.set_mode([S_WIDTH, S_HEIGHT])

wall = pygame.Surface((x, y))
wall.fill('Black')

end = pygame.Surface((x, y))
end.fill('Green')


def drawGrid(sur, FR):
    screen.fill((255, 255, 255))   

    sur.blit(end, (x*(WIDTH-1), y*(HEIGHT-1)))

    for i in range(WIDTH+1):  
        pygame.draw.line(sur, (0,0,0), (i*x,0), (i*x, S_HEIGHT))

    for j in range(HEIGHT+1):  
        pygame.draw.line(sur, (0,0,0), (0,j*y), (S_WIDTH, j*y))

    for i in range(WIDTH):
        for j in range(HEIGHT):
            if(grid[i][j][0]):
                sur.blit(wall, (x*i, y*j))
            if(grid[i][j][1]):
                pygame.draw.circle(sur, 'Red', (x*i + x/2, y*j + x/2), x/2)

    
    pygame.display.flip()

    clock.tick(FR)



def run():
    tryToMove(0, 0)

def tryToMove(a, b):                        #a, b - x and y to check
    drawGrid(screen, frameRate)
    if(a == WIDTH-1 and b == HEIGHT-1):
        grid[a][b][1] = True 
        return True
    else:
        grid[a][b][1] = True           #Place snake at the square
        if(a!=0):                      #Move left
            if not grid[a-1][b][0] and not grid[a-1][b][1]:
                if(tryToMove(a-1, b)):
                    return True
                else:
                    grid[a-1][b][1] = False #Delete snake if it was heading the wrong way
                    drawGrid(screen, frameRate)

        if(b!=0):                      #Move up
            if not grid[a][b-1][0] and not grid[a][b-1][1]:
                if(tryToMove(a, b-1)):
                    return True
                else:
                    grid[a][b-1][1] = False
                    drawGrid(screen, frameRate)

        if(a!=WIDTH-1):                      #Move right
            if not grid[a+1][b][0] and not grid[a+1][b][1]:
                if(tryToMove(a+1, b)):
                    return True
                else:
                    grid[a+1][b][1] = False
                    drawGrid(screen, frameRate)

        if(b!=HEIGHT-1):                      #Move down
            if not grid[a][b+1][0] and not grid[a][b+1][1]:
                if(tryToMove(a, b+1)):
                    return True
                else:
                    grid[a][b+1][1] = False
                    drawGrid(screen, frameRate) 
        return False         



while True:

    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            pygame.quit()
            exit()
        if event.type == pygame.KEYDOWN:
            if event.key == pygame.K_SPACE:
                pause = not pause
        if event.type == pygame.MOUSEBUTTONUP:
                pos = pygame.mouse.get_pos()
                curX = pos[0]//x
                curY = pos[1]//y
                if not ((curX == 0 and curY == 0) or (curX == WIDTH-1 and curY == HEIGHT-1)) :  #Just one ugly edge case, no reason for panic
                    grid[curX][curY][0] = not grid[curX][curY][0]

    if not pause:
        run()
        pause = True
    else:
        drawGrid(screen, frameRate)
    
